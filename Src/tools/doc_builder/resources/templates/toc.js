function swapTOC (listItem)
//Change tocs
{
	if (top.toc_frame)
	{
		tocUrl = listItem.value + "?index=" + listItem.selectedIndex.toString();
		top.toc_frame.location = tocUrl;
	}
}

function toggleTOC (show)
//Hide or show toc
{
	//alert ('DEBUG: Showing or hiding TOC')
	if (show)
	{
		top.column_frameset.cols = "250,*";
  		top.content_frame.document.all("showtoc").style.display = "none";	
  	}
  	else
  	{
		top.column_frameset.cols = "1,*";
  		top.content_frame.document.all("showtoc").style.display = "block";
  	}
}

function Toggle (node)
//Toggle node
{	
	if (node.nextSibling){
		// Unfold the branch if it isn't visible
		if (node.nextSibling.nextSibling != null)
		{
			var divNode = node.nextSibling.nextSibling;
			if (divNode != null && divNode.nodeName == "DIV")
			{
				if (divNode.style.display == 'none')
				{
					// Change the image (if there is an image)
					if (node.children.length > 0)
					{
						if (node.children.item(0).tagName == "IMG")
						{
							node.children.item(0).src = "icon_toc_folder_open.gif";
						}
					}

					node.nextSibling.nextSibling.style.display = '';
				}
				// Collapse the branch if it IS visible
				else
				{
					// Change the image (if there is an image)
					if (node.children.length > 0)
					{
						if (node.children.item(0).tagName == "IMG")
						{
							node.children.item(0).src = "icon_toc_folder_closed.gif";
						}
					}
					divNode.style.display = 'none';
				}
			}
		}
	}
}

function ToggleAll()
//Toggle ALL nodes
{
	if (top.toc_frame)
	{	
		var pageHrefs= top.toc_frame.document.getElementsByTagName("a")
	
		for (i = 0; i < pageHrefs.length; i++)
		{
			Toggle (pageHrefs[i]);
		}
	}
}