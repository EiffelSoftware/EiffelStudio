function swapTOC (listItem)
//Change tocs
{
	if (top.toc_frame)
	{
		tocUrl = listItem.value + "?index=" + listItem.selectedIndex.toString();
		top.toc_frame.location = tocUrl;
	}
}

function setNode(node, show)
//Set node display according to `show'
{	
	if (node.nextSibling)
	{		
		if (node.nextSibling.nextSibling != null)
		{
			var divNode = node.nextSibling.nextSibling;	
			if (divNode != null && divNode.nodeName == "DIV")
			{
				// Unfold the branch if it isn't visible
				if (show)
				{
					if (divNode.style.display == 'none')
					{
						// Change the image (if there is an image)
						if (node.childNodes.length > 0)
						{
							if (node.childNodes[0].tagName == "IMG")
							{
								node.childNodes[0].src = "icon_toc_folder_open.gif";
							}
						}
						node.nextSibling.nextSibling.style.display = '';
					}					
				}
				else				
				// Collapse the branch if it IS visible
				{
					if (divNode.style.display == '')
					{
						// Change the image (if there is an image)
						if (node.childNodes.length > 0)
						{
							if (node.childNodes[0].tagName == "IMG")
							{
								node.childNodes[0].src = "icon_toc_folder_closed.gif";
							}
						}
						divNode.style.display = 'none';
					}					
				}
			}
		}
	}
}

function toggle (node)
//Toggle node
{	
	if (node.nextSibling)
	{
		// Unfold the branch if it isn't visible
		if (node.nextSibling.nextSibling != null)
		{
			var divNode = node.nextSibling.nextSibling;	
			if (divNode != null && divNode.nodeName == "DIV")
			{
				if (divNode.style.display == 'none')
				{
					// Change the image (if there is an image)
					if (node.childNodes.length > 0)
					{
						if (node.childNodes[0].tagName == "IMG")
						{
							node.childNodes[0].src = "icon_toc_folder_open.gif";
						}
					}

					node.nextSibling.nextSibling.style.display = '';
				}
				// Collapse the branch if it IS visible
				else
				{
					// Change the image (if there is an image)
					if (node.childNodes.length > 0)
					{
						if (node.childNodes[0].tagName == "IMG")
						{
							node.childNodes[0].src = "icon_toc_folder_closed.gif";
						}
					}
					divNode.style.display = 'none';
				}
			}
		}
	}
}

function expandNode (node)
//Expand node for display
{		
	if (node.nextSibling)
	//DIV element
	{		
		var divNode = node.nextSibling;
		if (divNode != null && divNode.nodeName == "DIV")
		{			
			//show the parents, recursively					
			parentDiv = node.parentNode.parentNode.parentNode.parentNode.parentNode;
			//parent DIV element
			if (parentDiv.tagName == "DIV")
			{
				imgNode = parentDiv.previousSibling.previousSibling.firstChild;
				//IMG element associated to current DIV
				imgNode.src = "icon_toc_folder_open.gif";
				for (i = 0; parentDiv.tagName == "DIV"; i++)
				{					
					parentDiv.style.display = '';									
					parentDiv = parentDiv.parentNode.parentNode.parentNode.parentNode.parentNode;
					if (parentDiv.tagName == "DIV")
					{
						// Change the image (if there is an image)
						imgNode = parentDiv.previousSibling.previousSibling.firstChild;										
						imgNode.src = "icon_toc_folder_open.gif";
					}
				}
				//node.nextSibling.style.display = '';			
			}	
		}
		
	}
}

function setAll(show)
//Set all nodes according to `show'
{
	if (top.toc_frame)
	{	
		var pageHrefs = top.toc_frame.document.getElementsByTagName("a")
	
		for (i = 0; i < pageHrefs.length; i++)
		{
			setNode (pageHrefs[i], show);
		}
	}
}

function toggleAll()
//Toggle all nodes
{
	if (top.toc_frame)
	{	
		var pageHrefs = top.toc_frame.document.getElementsByTagName("a")
	
		for (i = 0; i < pageHrefs.length; i++)
		{
			Toggle (pageHrefs[i]);
		}
	}
}

function synchronize(aUrl)
//Synchronize the TOC with the 'url' displayed, if it is in the toc (take first occurence)
{			
	var links = document.getElementsByTagName("a");	
	var found;
	var matchNode;
	var url = aUrl.toLowerCase();
	
	if (links.length > 0)	
	{
		for (i = 0; i < links.length; i++)
		{		
			var linkUrl = links [i].href.toLowerCase();					
			if (url == linkUrl)
			{	
				matchNode = links [i];
				i = links.length + 1;				
				found = true;				
			}		
		}
		if (found)
		{
			setAll(false);
			expandNode (matchNode);
		}
	}	
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
