<!DOCTYPE HTML>
<%@ page language="java" import="java.util.*,com.aodci.bean.*"
	pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Indicaotr</title>
        <style type="text/css">
            input{
                padding:5px; margin: 20px; width:300px; font-size:20px; 
                border-radius:8px; background-color:#F1F1F1; border:1px solid #CCC;  
                box-shadow:3px 3px 4px #CCC inset;
                
                background-image: linear-gradient(0deg, #40C8F4 100%, transparent 0%);
                background-image: -webkit-linear-gradient(0deg, #40C8F4 100%, transparent 0%);
                background-repeat: no-repeat;
                background-position:0 100px;
                
                transition:200ms;
                -webkit-transition:200ms;
                -o-transition:200ms;
            }
            /* for ugly chrome */
            textarea:focus, input:focus{
                outline: none;
            }

            /* for centering only */
         
            html, body{ height:100%; text-align: center; }
            body:before{content:''; display:inline-block; height:100%; vertical-align:middle; margin-right:-0.25em; }
        </style>        
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>

    </head>
    <body>
        <input type="text" value="输入你想到的名称" />
        <script>
        (function($){
            var defaults = {
                    bgPos : '30px'
                },
                canvas = document.createElement('canvas'), // Canvas used to check text widths.
                context = canvas.getContext('2d'),
                iCaretPos, caret, totalWidth, cssRules, font, totalTextWidth, currentTextWidth,
                locationPercentage, textWidthRatio, settings, selectors = [],
            
                // find in which direction the user has selected the text, left or right
                getSelectionDirection = {
                    direction : null,
                    lastOffset : null,
                    set : function(e){
                        if( e.shiftKey && e.keyCode == 36 )
                            getSelectionDirection.direction = 'left';
                        else if( e.shiftKey && e.keyCode == 35 )
                            getSelectionDirection.direction = 'right';
                        if( e.type == 'mousedown' )
                            getSelectionDirection.lastOffset = e.clientX;
                        else if( e.type == 'mouseup' ){
                            getSelectionDirection.direction = e.clientX < getSelectionDirection.lastOffset ? 'left' : 'right';
                            //console.log(direction);
                        }
                    }
                };
            
            function getCaretPosition(oField, direction){    
                // if IE
                if( document.selection ){
                    oField.focus();
                    var oSel = document.selection.createRange();
                    oSel.moveStart('character', -oField.value.length);
                    iCaretPos = oSel.text.length;
                }
                else if( oField.selectionStart || oField.selectionStart == '0' )
                    iCaretPos = direction == 'left' ? oField.selectionStart : oField.selectionEnd;

                return iCaretPos || 0;
            }
            
            // because CUT and PASTE events are fired in jQuery before the value has changed
            function cutPasteDelay(e){
                var that = this;
                setTimeout(function(){
                    initIndicator.apply(that, e);
                },100);
            }
            
            function initIndicator(e){
                caret = getCaretPosition(this, getSelectionDirection.direction);
                totalWidth = $(this).width();    // width of the input field
                
                cssRules = window.getComputedStyle(this);
                font = {
                    size : parseInt(cssRules.getPropertyValue("font-size")),
                    family : cssRules.getPropertyValue('font-family')
                };
                totalTextWidth = checkTextWidth(this.value, font);
                currentTextWidth = checkTextWidth(this.value.substring(0,caret), font); // from the beginning index until current caret position
                
                locationPercentage = Math.floor((currentTextWidth / totalTextWidth) * 100);
                textWidthRatio = (totalWidth / totalTextWidth);
                    
                setStyles(this);
            }
            
            // update the visual style of the element
            function setStyles(el){
                // check the input's value overflows
                if( textWidthRatio > 1 )
                    textWidthRatio = 0;
                $(el).css({    
                    'background-size' : textWidthRatio*100 + '%',
                    'background-position' : locationPercentage + '% ' + settings.bgPos
                });
            }
            
            // check a given text lengh, acording to it's size and font family
            function checkTextWidth(text, font){
                context.font = font.size + "px " + font.family;

                if( context.fillText )
                    return context.measureText(text).width;
                else if( context.mozDrawText )
                    return context.mozMeasureText(text);
            }
            
            function destroy(selector){
                $(document)
                    .off('mousedown mouseup keydown', selector, getSelectionDirection.set)
                    .off('keydown keyup focus select mouseup cut paste', selector, initIndicator)
                    .off('cut paste', selector, cutPasteDelay);
                    
                // remove the selector from the list of selectors
                var index = selectors.indexOf(selector);
                selectors.splice(index, 1);
                // remove the visual indicator
                return $(selector).css('background-position', '');
            }
            
            $.fn.inputIndicator = function(options){
                var pluginSelector = this.selector;
                
                if( options == 'destroy' )
                    return destroy(pluginSelector);

                // merge settings
                settings = $.extend( {}, defaults, options );
                // check if the same selector was delegated already, not to create duplicate events on the Document
                if( selectors.indexOf(pluginSelector) != -1 )
                    return this;

                selectors.push( pluginSelector );
                // make sure to initialize any input element that is inserted to the DOM after the plugin has first ran.
                $(document).bind('DOMNodeInserted', function(e){
                    if( $(e.target).is(pluginSelector) )
                        $(e.target).trigger('keydown');
                    else
                        $(e.target).find(pluginSelector).trigger('keydown');
                });
                
                // init the whole thing and bind the events
                $(document)
                    .on('mousedown mouseup keydown', this.selector, getSelectionDirection.set)
                    .on('keydown keyup focus select mouseup cut paste', this.selector, initIndicator)
                    .on('cut paste', this.selector, cutPasteDelay);
                    
                this.trigger('mouseup'); // make the indicator show the first time (without any user interaction)
                return this;
            };
        })(jQuery);

        $(function(){
            $('input:text').inputIndicator({bgPos:'31px'});
        });

        </script>
    </body>
</html>

