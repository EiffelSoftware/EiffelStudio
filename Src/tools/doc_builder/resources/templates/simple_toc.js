function swapTOC (listItem)
//Change tocs
{
	if (top.toc_frame)
	{
		tocUrl = listItem.value + "?index=" + listItem.selectedIndex.toString();
		top.toc_frame.location = tocUrl;		
		if (listItem.value.search ('envision/HTML') > 1)
		{
			top.content_frame.location = '../envision/index.html';
		}
		else			
		{
			top.content_frame.location = '../eiffelstudio/index.html';
		}
	}
}

function changeSubTOC (subTOCUrl)
{	
	top.toc_frame.location = subTOCUrl;
}

function setCookie (name, value, expires) 
//Set a cookie
{
	if (!expires) 
  	{
  		expires = new Date();
  	}
  	document.cookie = name + '=' + escape(value) + '; expires=' + expires.toGMTString() + '; path=/';
}


function getCookie(name) 
//Return string containing value of specified cookie or null if cookie does not exist
{
  	var dc = document.cookie;
  	var prefix = name + "=";
  	var begin = dc.indexOf("; " + prefix);
  	if (begin == -1) 
  	{
  		begin = dc.indexOf(prefix);
  		if (begin != 0) return null;
  	}
  	else
    		begin += 2;
 	var end = document.cookie.indexOf(";", begin);
  	if (end == -1)
    		end = dc.length;
  
  	return unescape(dc.substring(begin + prefix.length, end));
}
