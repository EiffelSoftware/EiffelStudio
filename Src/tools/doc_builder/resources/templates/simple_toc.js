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

function pageLoad()
//Page load function
{	
	if (top.filter_frame.document.theForm.filterMenu)
	{
		selectFilterNode();
	}
	loadCookie();
}

function selectFilterNode()
//Select appropriate filter node in combo box based on query string value
//passed from previous page
{

	//keep everything after the '?'
	query = document.location.toString()
	query = query.substring ((query.indexOf('?')) + 1);

	if (!query.length < 1)
	{
		keypairs = new Object();
		numKP = 1;

		while (query.indexOf('&') > -1)
		{
			keypairs[numKP] = query.substring(0,query.indexOf('&'));
			query = query.substring((query.indexOf('&')) + 1);
			numKP++;
		}

		keypairs[numKP] = query;
		// Store what's left in the query string as the final keypairs[] data.

		for (i in keypairs)
		{
			keyName = keypairs[i].substring(0,keypairs[i].indexOf('='));
			// Left of '=' is name.
			keyValue = keypairs[i].substring((keypairs[i].indexOf('=')) + 1);
			// Right of '=' is value.
		}
		if (keyName == "index")
		{
			keyValue = unescape(keyValue);
			top.filter_frame.document.theForm.filterMenu.options [keyValue].selected = true;
		}
	}
}

function loadCookie()
//Load into the content page the file found in cookie.  Used for redirecting back to the required page
//when a non-frames url is entered into the browser.  If there is no cookie just use the default.
{

	var cookieValue = getCookie ("redirecturl");
	if (cookieValue)
	{
		parent.content_frame.location.href = cookieValue;
	}

}

function documentLoaded (aUrl)
//A new document was loaded in the content frame, so filter it based on filter, and sync the toc.
{

	//Synchronize the TOC
	//synchronize (aUrl);

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
