function checkFloat(myfield, e)
{
	var key;
	var keychar;
	
	if (window.event)
	{
		key = window.event.keyCode;
	}
	else if (e)
	{
		key = e.which;
	}
	else
	{
		return true;
	}
	   
	keychar = String.fromCharCode(key);
	
	// Process if the tab key (key #9) or a number is pressed.  Otherwise, return false
	if (key == 9 || key == 0 || key == 8)
	{
			   return true;
	}
	else if (("0123456789\.").indexOf(keychar) > -1)
	{
		return true;
	}
	else
	{
		alert('Numerical values or the tab key only');
		return false;		
	}
}

function checkNumber(myfield, e)
{
	var key;
	var keychar;
	
	if (window.event)
	{
		key = window.event.keyCode;
	}
	else if (e) 
	{
		key = e.which;
	}
	else 
	{
		return true;
	}

	keychar = String.fromCharCode(key);
	
	// Process if the tab key (key #9) or a number is pressed.  Otherwise, return false
	if (key == 9 || key == 0 || key == 8)
	{
		return true;
	}
	else if (("0123456789").indexOf(keychar) > -1)
	{
		return true;
	}
	else
	{
		alert('Numerical values or the tab key only');
		return false;		
	}
	   
}