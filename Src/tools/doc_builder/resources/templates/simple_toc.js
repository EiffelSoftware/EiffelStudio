function swapTOC (listItem)
//Change product tocs
{
	if (top.toc_frame)
	{	
		var now = new Date();
		var expdate = new Date (now.getTime () + 1 * 24 + 60 * 60 * 1000);
		if (listItem.value.search ('envision/sub_tocs') > 0)
		{
			setCookie ('filterIndex', listItem.selectedIndex.toString(), expdate);
			deleteCookie ('tocName');
			setCookie ('tocName', 'envision', null);
			loadContent ('../envision/HTMLSimpleFilterTemplate.html', top.filter_frame);
			loadContent ('../envision/index.html', top.content_frame);									
		}
		else
		{
			setCookie ('filterIndex', listItem.selectedIndex.toString(), expdate);
			deleteCookie ('tocName');
			setCookie ('tocName', 'eiffelstudio', null);
			loadContent ('../eiffelstudio/HTMLSimpleFilterTemplate.html', top.filter_frame);
			loadContent ('../eiffelstudio/index.html', top.content_frame);						
		}
		loadContent (listItem.value, top.toc_frame);
	}
}

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
	//Select the correct product toc in the list
	if (top.filter_frame.document)
	{
		if (top.filter_frame.document.theForm)
		{
			if (top.filter_frame.document.theForm.filterMenu != null)
			{
				selectFilterNode();
			}	
		}
	}
	
	//If there is redirect page then load this page into the content frame.  If the redirect page does not belong to the product toc currently in use then load the appropriate toc hash.  Once done remove the cookies to avoid future problems.
	var redirectValue = getCookie ("redirecturl");
	if (redirectValue)
	{		
		if (fileMatchesTocHash())
		{
			var fileLocation = '../' + redirectValue						
		}
		else		
		{
			if (getCookie ("tocName") != null)
			{
				var tocNameValue = getCookie ("tocName");
				var fileLocation = '../../' + tocNameValue + '/' + redirectValue;
				loadContent ('../../' + tocNameValue + '/HTMLSimpleFilterTemplate.html', top.filter_frame);
			}			
			
		}		
		loadContent(fileLocation, parent.content_frame);
		
		var removeCookie = getCookie ("delete");
		if (removeCookie)
		{					
			deleteCookie("delete");
		}
	}	
}

function fileMatchesTocHash()
//Determine if the file in the content frame belongs to the product toc currently loaded in the filter frame toc hash.
{
	var fileTocName = getCookie ("tocName");
	if (fileTocName)
	{
		var filterToc = parent.filter_frame.location.href.substring (0, parent.filter_frame.location.href.lastIndexOf ("/"));	
		var filterTocName = filterToc.substring (filterToc.lastIndexOf ("/") + 1, filterToc.length);		
		if (filterTocName == fileTocName)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}

function selectFilterNode()
//Select appropriate filter node in combo box based on query string value
//passed from previous page
{	
	var filterIndex = getCookie ("filterIndex");
	if (filterIndex)
	{
		top.filter_frame.document.theForm.filterMenu.options [filterIndex].selected = true;
		deleteCookie ('filterIndex');
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

	//Extract filter words from filter string
	var widget = top.filter_frame.document.theForm.filterMenu;
	if (widget)
	{
		var filterString =  widget [widget.selectedIndex].name;

		if (!filterString.length < 1)
		{
			filterStrings = new Object();
			cnt = 1;

			while (filterString.indexOf(',') > -1)
			{
				filterStrings [cnt] = filterString.substring(0, filterString.indexOf(','));
				filterString = filterString.substring((filterString.indexOf(',')) + 1);
				cnt++;
			}

			filterStrings [cnt] = filterString;
		}

		//Get filter string and document span tag elements
		var pageSpans = parent.content_frame.document.getElementsByTagName("span")

		for (i = 0; i < pageSpans.length; i++)
		{
			spanId = pageSpans[i].getAttribute('id');

			match = spanId == "";

			if (!match)
			{
				//Look for match in strings against span id
				for (j in filterStrings)
				{
					if (spanId == filterStrings [j])
					{
						match = true;
					}
				}
			}

			//Process match (or not)
			if (!match)
			{
				pageSpans[i].style.display = 'none'
			}
			else
			{
				pageSpans[i].style.display = ''
			}
		}
	}
}