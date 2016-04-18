<div id="disqus_thread"></div>
<script>
/**
* RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
* LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables
*/
{literal}
var disqus_config = function () {
{/literal}
{if isempty="$wiki_uuid"}
this.page.url = window.location.href; // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = 'wdocs-{$wiki_book_name/}__{$wiki_page_name/}'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
{/if}
{unless isempty="$wiki_uuid"}
this.page.url = "{$site_url/}doc/uuid/{$wiki_uuid/}"; // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = 'wdocs-{$wiki_uuid/}'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
{/unless}
this.page.title = "[{$wiki_book_name/}] {$wiki_page_name/}";
//this.page.category_id = "eiffel-org";
{literal}
};
(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');

s.src = '//eiffel.disqus.com/embed.js';

s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
{/literal}
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus!</a></noscript>
