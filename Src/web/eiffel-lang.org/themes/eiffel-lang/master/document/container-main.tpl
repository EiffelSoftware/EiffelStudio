					<div class="container">
						<div id="content" class="documentation">
							<div class="holder">
{if isset="$content"}
			  <h1>
			  		{if isset="$wiki_book_name"}<a href="{$site_url/}/book/{$wiki_book_name/}">{$wiki_book_name/}</a>{/if}
			  		{if isset="$wiki_page_name"}:: {$wiki_page_name/}{/if}</h1>
			  <div class="wikipage">{$content/}</div>
{/if}
{unless isset="$content"}
								<header class="head">
									<h1><span class="ico"><img src="/theme/images/ico-documnet.png" width="21" height="21" alt="Image Description"></span>Document Name</h1>
									<p>Detailed definitions behind all aspects of the Eiffel Language and Development Environment.</p>
								</header>
								{include file="master/document/info_block.tpl"/}
{/unless}
							</div>
						</div>
<!-- Commented for now, no right side bar
						<aside id="sidebar">
							<div class="holder">
								<div class="socail-plugin"><img src="/theme/images/img-plugin.jpg" width="248" height="88" alt="Image Description"></div>
								<nav class="widget">
									<h2><a href="#">Similar</a></h2>
									<ul>
										<li><a href="#">EiffelBase</a></li>
										<li><a href="#">EiffelVision 2</a></li>
										<li><a href="#">EiffelCOM</a></li>
										<li><a href="#">EiffelNet</a></li>
									</ul>
								</nav>
								<div class="widget">
									<h2><a href="#">Archive</a></h2>
									<ul>
										<li><time datetime="2014-09-12" class="date">12.09.2014</time> <a href="#">Eiffel Game Library</a></li>
										<li><time datetime="2014-09-12" class="date">12.09.2014</time> <a href="#">HTML5 Microdata Parser</a></li>
										<li><time datetime="2014-09-12" class="date">12.09.2014</time> <a href="#">Smarty Template Engine</a></li>
										<li><time datetime="2014-09-12" class="date">12.09.2014</time> <a href="#">Wikitext</a></li>
									</ul>
								</div>
							</div>
						</aside>
-->
					</div>
