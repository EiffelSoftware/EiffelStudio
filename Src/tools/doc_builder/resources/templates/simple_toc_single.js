function changeSubTOC (subTocUrl)
//Change the toc displayed
{	
	loadContent (subTocUrl, top.toc_frame);
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

function loadContent(aUrl, aFrame)
//Load into `aFrame' page the file at location `aUrl'.
{
	aFrame.location.href = aUrl;
}

function deleteCookie(name)
//Delete the cookie with `name'
{
	var date = new Date;
	date.setFullYear(date.getFullYear( ) -10);			  
	setCookie (name, '', date);
}

function pageLoad()
//Page load function
{		
	//If there is redirect page then load this page into the content frame.  If the redirect page does not belong to the product toc currently in use then load the appropriate toc hash.  Once done remove the cookies to avoid future problems.
	var redirectValue = getCookie ("redirecturl");
	if (redirectValue)
	{		
		
		var fileLocation = '../' + redirectValue						
		loadContent(fileLocation, parent.content_frame);
		
		var removeCookie = getCookie ("delete");
		if (removeCookie)
		{					
			deleteCookie("delete");
		}
	}	
}

function documentLoaded (aUrl)
//A new document was loaded in the content frame, so filter it based on filter, and sync the toc.
{
	//Synchronize the TOC
	if (getCookie("redirecturl") != null)
	{
		deleteCookie("redirecturl");			
		top.filter_frame.synchronize (aUrl);	
	}
}

function fileMatchesTocHash()
{
	return true;
}
