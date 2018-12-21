<div id="remark42"></div>
<script>
{literal}
  var remark_config = {
    site_id: 'eiffel-org-comments',
{/literal}
{if isempty="$wiki_uuid"}
    url: '', // optional param; if it isn't defined window.location.href will be used
{/if}
{unless isempty="$wiki_uuid"}
    url: '{$site_url/}doc/uuid/{$wiki_uuid/}', // Replace PAGE_URL with your page's canonical URL variable
{/unless}
{literal}
    max_shown_comments: 25, // optional param; if it isn't defined default value (15) will be used
    theme: 'dark', // optional param; if it isn't defined default value ('light') will be used
  };

  (function() {
    var d = document, s = d.createElement('script');
    s.src = 'https://remark.eiffel.org/web/embed.js'; // prepends this address with domain where remark42 is placed
    (d.head || d.body).appendChild(s);
  })();
{/literal}
</script>
