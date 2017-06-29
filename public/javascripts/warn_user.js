/**
 * Author:		Amit Patel
 * Description: This script warns the user if they have already started taking the benefits survey and then navigate to a different page.
 */
    needToConfirm = false;
    window.onbeforeunload = askConfirm;
    
    function askConfirm(){
        if (needToConfirm){
            return "You have started the benefits survey. You will lose your answers if you navigate to another page.";
            }    
        }
