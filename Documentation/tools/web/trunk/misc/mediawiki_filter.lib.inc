<?php

/**
 * @file
 * These functions and classes provide an environment for the Mediawiki parser.
 *
 * The mapping is the following:
 *
 * Mediawiki       | Drupal
 * ------------------------------
 * Article/Page ID | Node ID
 * Revision ID     | Revision ID       / not really needed, we always take the latest revision of templates/images
 * Article title   | Node title
 * Namespace       | Node type
 * NS_MAIN         | type = 'wiki'
 * NS_TEMPLATE     | type = 'template'
 * NS_IMAGE        | type = 'image'
 * NS_USER         | ?
 * NS_PROJECT      | ?
 * User ID         | User ID
 * User Name       | User Name
 *
 * No talk pages are available, comments are used instead.
 * No special pages are available.
 *
 * TODO:
 * The mapping of namespace to node type is too restricting. There should be a way to map namespaces to a category,
 * then the titles inside this category should be unique.
 */

/**
 * Parse $text with mediawiki parser.
 */
function _mediawiki_filter_parse($text) {
  global $wgParser, $wgUser;

  _mediawiki_filter_initialize_environment();

  $title = new Title('Dummy');
  $options = new ParserOptions();
  // Make signature replacement (~~~~)
//  $text = $wgParser->preSaveTransform($text, $title, $wgUser, $options);
  // Do rendering
  $output = $wgParser->parse($text, $title, $options);

  return $output->getText();
}


function _mediawiki_filter_initialize_environment() {
  static $is_initialized = FALSE;
  if ($is_initialized) {
    return;
  }
  $is_initialized = TRUE;

  // Needed to include Mediawiki files.
  define('MEDIAWIKI', 1);

  // Set up Mediawiki's fake root path.
  global $IP;
  $IP = realpath(drupal_get_path('module', 'mediawiki_filter') . '/lib');

  // Set up some global variables needed for Mediawiki.
  $settings = array(
    'wgServer' => url(NULL, NULL, NULL, TRUE),
    'wgScriptPath' => '/xyz',
    'wgScript' => '/xyz/index.php',
    'wgRedirectScript' => '/xyz/redirect.php',
    'wgArticlePath' => 'wiki/$1',
    'wgActionPaths' => array(),
    'wgContLanguageCode' => 'en',
    'wgRawHtml' => FALSE, // Should be disabled for security
    'wgNamespacesWithSubpages' => array(),  // ?
    'wgCapitalLinks' => TRUE,
    'wgUseTeX' => FALSE,
    'wgLocaltimezone' => 'UTC',
    'wgAllowExternalImages' => TRUE,
    'wgUseTidy' => FALSE,
    'wgVariantArticlePath' => FALSE,
    'wgSitename' => variable_get('site_name', 'Drupal'),  // Needed for {{SITENAME}} variable
    'wgMaxArticleSize' => 2048,                 // Needed that templates get loaded
    'wgSpecialPages' => array(),                // Needed that no PHP-errors occur
    'wgMaxTocLevel' => 999,                     // Needed that TOC is generated
    'wgUrlProtocols' => array(
      'http://',
      'https://',
      'ftp://',
      'irc://',
      'gopher://',
      'telnet://', // Well if we're going to support the above.. -ævar
      'nntp://', // @bug 3808 RFC 1738
      'worldwind://',
      'mailto:',
      'news:'
    ),
    'wgLegalTitleChars' => " %!\"$&'()*,\\-.\\/0-9:;=?@A-Z\\\\^_`a-z~\\x80-\\xFF+",
    'wgHooks' => array(),
    'wgExtensionMessagesFiles' => array(),  // Needed for extensions (e.g. Cite)
    'wgExtensionFunctions' => array(),  // Needed for extensions (e.g. Cite)
  );
  foreach( $settings as $var => $val ) {
    $GLOBALS[$var] = $val;
  }

  // Faked (and some copied) global functions.
  require_once("mediawiki_filter.global_functions.inc");

  // Required Mediawiki files.
  require_once("$IP/includes/CoreParserFunctions.php");
  require_once("$IP/includes/Defines.php");
  require_once("$IP/includes/Hooks.php");
  require_once("$IP/includes/ImageGallery.php");
  require_once("$IP/includes/MagicWord.php");
  require_once("$IP/includes/MessageCache.php");
  require_once("$IP/includes/Namespace.php"); // CHECK REMOVAL
  $GLOBALS['wgCanonicalNamespaceNames'] = $wgCanonicalNamespaceNames;
  require_once("$IP/includes/ObjectCache.php");                       // CHECK REMOVAL
  require_once("$IP/includes/Parser.php");
  require_once("$IP/includes/ParserOutput.php");
  require_once("$IP/includes/ParserOptions.php");
  require_once("$IP/includes/StringUtils.php");
  require_once("$IP/includes/Sanitizer.php");
  require_once("$IP/includes/SpecialPage.php");
  require_once("$IP/includes/Xml.php");
  require_once("$IP/includes/XmlFunctions.php");
  require_once("$IP/includes/normal/UtfNormal.php");
  require_once("$IP/languages/Language.php");
  $GLOBALS['wgLanguageNames'] = $wgLanguageNames;

  // Faked classes.
  require_once("mediawiki_filter.classes.inc");

  global $wgMemc;
  $wgMemc = new FakeMemCachedClient;

  global $wgParser;
  $wgParser = new MediawikiFilterParser();

  global $wgUser;
  $wgUser = new User();

  global $wgContLang, $wgLang;
  $wgContLang = Language::factory( 'en' );
  $wgLang = $wgContLang;

  global $wgMessageCache;
  $temp = NULL;
  $wgMessageCache = new MessageCache($temp, FALSE, 0, NULL);

  // Load extensions
  global $wgHooks;
  $wgHooks['ParserAfterTidy'][] = 'ignoreCodeTagAfterTidy';
  $wgParser->setHook('code', 'ignoreCodeTag');

// TODO: doesn't work in the stripped version of Mediawiki...
//   global $wgExtensionFunctions;
//   require_once("$IP/extensions/Cite/Cite.php");
//   foreach ( $wgExtensionFunctions as $func ) {
//     $profName = $fname.'-extensions-'.strval( $func );
//     wfProfileIn( $profName );
//     call_user_func( $func );
//     wfProfileOut( $profName );
//   }

}

/**
 * TODO: this is hard-coded at the moment and shoul be more customizable
 */
function ignoreCodeTag($text, $args) {
  global $_tagMarkers;
  $arguments = '';
  foreach($args as $name => $value) {
    $arguments .= ' ' . $name . '="' . $value . '"';
  }
  $output = "<code$arguments>$text</code>";
  $markercount =  count($_tagMarkers);
  $marker = "xx-tagmarker".$markercount."-xx";
  $_tagMarkers[$markercount] = $output;
  return $marker;
}

function ignoreCodeTagAfterTidy(&$parser, &$text) {
  global $_tagMarkers;
  for ($i=0;$i<count($_tagMarkers);$i++)
    $text = preg_replace('/xx-tagmarker'.$i.'-xx/',$_tagMarkers[$i],$text);
  return true;
}

/** Debug function */
function printLine($line) {
//  print("$line\t\t<br/>\n");
}

/**
 * Dummy title class
 * TODO: Major cleanup
 */
class Title {

  /**
   * Static cache variables
   */
  static private $titleCache=array();
  static private $interwikiCache=array();

  var $mTextform;           # Text form (spaces not underscores) of the main part
  var $mUrlform;            # URL-encoded form of the main part
  var $mDbkeyform;          # Main part with underscores
  var $mNamespace;          # Namespace index, i.e. one of the NS_xxxx constants
  var $mInterwiki;          # Interwiki prefix (or NULL string)
  var $mArticleID;          # Article ID, fetched from the link cache on demand
  var $mPrefixedText;       # Text form including namespace/interwiki, initialised on demand

  /**
   * Constructor
   * @private
   */
  function __construct() {
    $this->mInterwiki = $this->mUrlform = '';
    $this->mTextform = $this->mDbkeyform = '';
    $this->mArticleID = -1;
    $this->mNamespace = NS_MAIN;
  }

  /**
   * Create a new Title from text, such as what one would
   * find in a link. Decodes any HTML entities in the text.
   *
   * @param string $text the link text; spaces, prefixes,
   *  and an initial ':' indicating the main namespace
   *  are accepted
   * @param int $defaultNamespace the namespace to use if
   *   none is specified by a prefix
   * @return Title the new object, or NULL on an error
   */
  public static function newFromText( $text, $defaultNamespace = NS_MAIN ) {
    if( is_object( $text ) ) {
      throw new MWException( 'Title::newFromText given an object' );
    }

    /**
     * Wiki pages often contain multiple links to the same page.
     * Title normalization and parsing can become expensive on
     * pages with many links, so we can save a little time by
     * caching them.
     *
     * In theory these are value objects and won't get changed...
     */
    if( $defaultNamespace == NS_MAIN && isset( Title::$titleCache[$text] ) ) {
      return Title::$titleCache[$text];
    }

    /**
     * Convert things like &eacute; &#257; or &#x3017; into real text...
     */
    $filteredText = Sanitizer::decodeCharReferences( $text );

    $t = new Title();
    $t->mDbkeyform = str_replace( ' ', '_', $filteredText );
    $t->mDefaultNamespace = $defaultNamespace;

    if( $t->secureAndSplit() ) {
      if( $defaultNamespace == NS_MAIN ) {
        Title::$titleCache[$text] =& $t;
      }
      return $t;
    } else {
      $ret = NULL;
      return $ret;
    }
  }

  /**
   * Create a new Title from a namespace index and a DB key.
   * It's assumed that $ns and $title are *valid*, for instance when
   * they came directly from the database or a special page name.
   * For convenience, spaces are converted to underscores so that
   * eg user_text fields can be used directly.
   *
   * @param int $ns the namespace of the article
   * @param string $title the unprefixed database key form
   * @return Title the new object
   */
  public static function &makeTitle( $ns, $title ) {
    $t = new Title();
    $t->mInterwiki = '';
    $t->mFragment = '';
    $t->mNamespace = $ns = intval( $ns );
    $t->mDbkeyform = str_replace( ' ', '_', $title );
    $t->mArticleID = ( $ns >= 0 ) ? -1 : 0;
    $t->mUrlform = wfUrlencode( $t->mDbkeyform );
    $t->mTextform = str_replace( '_', ' ', $title );
    return $t;
  }

  /**
   * Secure and split - main initialisation function for this object
   *
   * Assumes that mDbkeyform has been set, and is urldecoded
   * and uses underscores, but not otherwise munged.  This function
   * removes illegal characters, splits off the interwiki and
   * namespace prefixes, sets the other forms, and canonicalizes
   * everything.
   * @return bool TRUE on success
   */
  private function secureAndSplit() {
    global $wgContLang, $wgLocalInterwiki, $wgCapitalLinks;

    # Initialisation
    static $rxTc = FALSE;
    if( !$rxTc ) {
      # % is needed as well
      $rxTc = '/[^' . Title::legalChars() . ']|%[0-9A-Fa-f]{2}/S';
    }

    $this->mInterwiki = $this->mFragment = '';
    $this->mNamespace = $this->mDefaultNamespace; # Usually NS_MAIN
    
    $dbkey = $this->mDbkeyform;

    # Strip Unicode bidi override characters.
    # Sometimes they slip into cut-n-pasted page titles, where the
    # override chars get included in list displays.
    $dbkey = str_replace( "\xE2\x80\x8E", '', $dbkey ); // 200E LEFT-TO-RIGHT MARK
    $dbkey = str_replace( "\xE2\x80\x8F", '', $dbkey ); // 200F RIGHT-TO-LEFT MARK
    
    # Clean up whitespace
    #
    $dbkey = preg_replace( '/[ _]+/', '_', $dbkey );
    $dbkey = trim( $dbkey, '_' );

    if ( '' == $dbkey ) {
      return FALSE;
    }

    if( FALSE !== strpos( $dbkey, UTF8_REPLACEMENT ) ) {
      # Contained illegal UTF-8 sequences or forbidden Unicode chars.
      return FALSE;
    }

    $this->mDbkeyform = $dbkey;

    # Initial colon indicates main namespace rather than specified default
    # but should not create invalid {ns,title} pairs such as {0,Project:Foo}
    if ( ':' == $dbkey{0} ) {
      $this->mNamespace = NS_MAIN;
      $dbkey = substr( $dbkey, 1 ); # remove the colon but continue processing
      $dbkey = trim( $dbkey, '_' ); # remove any subsequent whitespace
    }

    # Namespace or interwiki prefix
    $firstPass = TRUE;
    do {
      $m = array();
      if ( preg_match( "/^(.+?)_*:_*(.*)$/S", $dbkey, $m ) ) {
        $p = $m[1];
        if ( $ns = $wgContLang->getNsIndex( $p )) {
          # Ordinary namespace
          $dbkey = $m[2];
          $this->mNamespace = $ns;
        } elseif( $this->getInterwikiLink( $p ) ) {
          if( !$firstPass ) {
            # Can't make a local interwiki link to an interwiki link.
            # That's just crazy!
            return FALSE;
          }

          # Interwiki link
          $dbkey = $m[2];
          $this->mInterwiki = $wgContLang->lc( $p );

          # Redundant interwiki prefix to the local wiki
          if ( 0 == strcasecmp( $this->mInterwiki, $wgLocalInterwiki ) ) {
            if( $dbkey == '' ) {
              # Can't have an empty self-link
              return FALSE;
            }
            $this->mInterwiki = '';
            $firstPass = FALSE;
            # Do another namespace split...
            continue;
          }

          # If there's an initial colon after the interwiki, that also
          # resets the default namespace
          if ( $dbkey !== '' && $dbkey[0] == ':' ) {
            $this->mNamespace = NS_MAIN;
            $dbkey = substr( $dbkey, 1 );
          }
        }
        # If there's no recognized interwiki or namespace,
        # then let the colon expression be part of the title.
      }
      break;
    } while( TRUE );

    # We already know that some pages won't be in the database!
    #
    if ( '' != $this->mInterwiki || NS_SPECIAL == $this->mNamespace ) {
      $this->mArticleID = 0;
    }
    $fragment = strstr( $dbkey, '#' );
    if ( FALSE !== $fragment ) {
      $this->setFragment( $fragment );
      $dbkey = substr( $dbkey, 0, strlen( $dbkey ) - strlen( $fragment ) );
      # remove whitespace again: prevents "Foo_bar_#"
      # becoming "Foo_bar_"
      $dbkey = preg_replace( '/_*$/', '', $dbkey );
    }

    # Reject illegal characters.
    #
    if( preg_match( $rxTc, $dbkey ) ) {
      return FALSE;
    }

    /**
     * Pages with "/./" or "/../" appearing in the URLs will
     * often be unreachable due to the way web browsers deal
     * with 'relative' URLs. Forbid them explicitly.
     */
    if ( strpos( $dbkey, '.' ) !== FALSE &&
         ( $dbkey === '.' || $dbkey === '..' ||
           strpos( $dbkey, './' ) === 0  ||
           strpos( $dbkey, '../' ) === 0 ||
           strpos( $dbkey, '/./' ) !== FALSE ||
           strpos( $dbkey, '/../' ) !== FALSE ) )
    {
      return FALSE;
    }
    
    /**
     * Magic tilde sequences? Nu-uh!
     */
    if( strpos( $dbkey, '~~~' ) !== FALSE ) {
      return FALSE;
    }

    /**
     * Limit the size of titles to 255 bytes.
     * This is typically the size of the underlying database field.
     * We make an exception for special pages, which don't need to be stored
     * in the database, and may edge over 255 bytes due to subpage syntax 
     * for long titles, e.g. [[Special:Block/Long name]]
     */
    if ( ( $this->mNamespace != NS_SPECIAL && strlen( $dbkey ) > 255 ) ||
      strlen( $dbkey ) > 512 ) 
    {
      return FALSE;
    }

    /**
     * Normally, all wiki links are forced to have
     * an initial capital letter so [[foo]] and [[Foo]]
     * point to the same place.
     *
     * Don't force it for interwikis, since the other
     * site might be case-sensitive.
     */
    $this->mUserCaseDBKey = $dbkey;
    if( $wgCapitalLinks && $this->mInterwiki == '') {
      $dbkey = $wgContLang->ucfirst( $dbkey );
    }

    /**
     * Can't make a link to a namespace alone...
     * "empty" local links can only be self-links
     * with a fragment identifier.
     */
    if( $dbkey == '' &&
      $this->mInterwiki == '' &&
      $this->mNamespace != NS_MAIN ) {
      return FALSE;
    }
    // Allow IPv6 usernames to start with '::' by canonicalizing IPv6 titles.
    // IP names are not allowed for accounts, and can only be referring to 
    // edits from the IP. Given '::' abbreviations and caps/lowercaps, 
    // there are numerous ways to present the same IP. Having sp:contribs scan 
    // them all is silly and having some show the edits and others not is 
    // inconsistent. Same for talk/userpages. Keep them normalized instead.
// TODO: Is this necessary
//    $dbkey = ($this->mNamespace == NS_USER || $this->mNamespace == NS_USER_TALK) ? 
//      IP::sanitizeIP( $dbkey ) : $dbkey;
    // Any remaining initial :s are illegal.
    if ( $dbkey !== '' && ':' == $dbkey{0} ) {
      return FALSE;
    }
    
    # Fill fields
    $this->mDbkeyform = $dbkey;
    $this->mUrlform = wfUrlencode( $dbkey );

    $this->mTextform = str_replace( '_', ' ', $dbkey );

    return TRUE;
  }

  /**
   * Get a regex character class describing the legal characters in a link
   * @return string the list of characters, not delimited
   */
  public static function legalChars() {
    global $wgLegalTitleChars;
    return $wgLegalTitleChars;
  }

  /**
   * Is this a talk page of some sort?
   * @return bool
   */
  public function isTalkPage() {
    return FALSE;
  }

  /**
   * Get the prefixed title with spaces.
   * This is the form usually used for display
   * @return string the prefixed title, with spaces
   */
  public function getPrefixedText() {
    if ( empty( $this->mPrefixedText ) ) { // FIXME: bad usage of empty() ?
      $s = $this->prefix( $this->mTextform );
      $s = str_replace( '_', ' ', $s );
      $this->mPrefixedText = $s;
    }
    return $this->mPrefixedText;
  }

  public function quickUserCan( $action ) {
    printLine("Title.quickUserCan($action)");
    return TRUE;
    return $this->userCan( $action, FALSE );
  }

  /**
   * Prefix some arbitrary text with the namespace or interwiki prefix
   * of this object
   *
   * @param string $name the text
   * @return string the prefixed text
   * @private
   */
  function prefix( $name ) {
    $p = '';
    if ( '' != $this->mInterwiki ) {
            $p = $this->mInterwiki . ':';
    }
    if ( 0 != $this->mNamespace ) {
            $p .= $this->getNsText() . ':';
    }
    return $p . $name;
  }

  /**
   * Get an HTML-escaped version of the URL form, suitable for
   * using in a link, without a server name or fragment
   * @param string $query an optional query string
   * @return string the URL
   */
  public function escapeLocalURL( $query = '' ) {
    return htmlspecialchars( $this->getLocalURL( $query ) );
  }

  public function getArticleID() { return $this->mArticleID; }

  /**
   * Get the text form (spaces not underscores) of the main part
   * @return string
   */
  public function getText() { return $this->mTextform; }

  /**
   * Get the URL-encoded form of the main part
   * @return string
   */
  public function getPartialURL() { return $this->mUrlform; }

  /**
   * Get the main part with underscores
   * @return string
   */
  public function getDBkey() { return $this->mDbkeyform; }

  /**
   * Get the namespace index, i.e. one of the NS_xxxx constants
   * @return int
   */
  public function getNamespace() { return $this->mNamespace; }

  /**
   * Get the namespace text
   * @return string
   */
  public function getNsText() {
    global $wgContLang, $wgCanonicalNamespaceNames;

    if ( '' != $this->mInterwiki ) {
      // This probably shouldn't even happen. ohh man, oh yuck.
      // But for interwiki transclusion it sometimes does.
      // Shit. Shit shit shit.
      //
      // Use the canonical namespaces if possible to try to
      // resolve a foreign namespace.
      if( isset( $wgCanonicalNamespaceNames[$this->mNamespace] ) ) {
        return $wgCanonicalNamespaceNames[$this->mNamespace];
      }
    }
    return $wgContLang->getNsText( $this->mNamespace );
  }

  /**
   * Get the interwiki prefix (or NULL string)
   * @return string
   */
  public function getInterwiki() { return $this->mInterwiki; }

  /**
   * Get the Title fragment (i.e. the bit after the #) in text form
   * @return string
   */
  public function getFragment() { return $this->mFragment; }

  /**
   * Get the fragment in URL form, including the "#" character if there is one
   * @return string
   */
  public function getFragmentForURL() {
    if ( $this->mFragment == '' ) {
      return '';
    } else {
      return '#' . Title::escapeFragmentForURL( $this->mFragment );
    }
  }

  /**
   * Set the fragment for this title
   * This is kind of bad, since except for this rarely-used function, Title objects
   * are immutable. The reason this is here is because it's better than setting the 
   * members directly, which is what Linker::formatComment was doing previously.
   *
   * @param string $fragment text
   * @todo clarify whether access is supposed to be public (was marked as "kind of public")
   */
  public function setFragment( $fragment ) {
    $this->mFragment = str_replace( '_', ' ', substr( $fragment, 1 ) );
  }

  /**
   * Get the prefixed database key form
   * @return string the prefixed title, with underscores and
   *   any interwiki and namespace prefixes
   */
  public function getPrefixedDBkey() {
    $s = $this->prefix( $this->mDbkeyform );
    $s = str_replace( ' ', '_', $s );
    return strtolower($s);
  }

  /**
   * Get the HTML-escaped displayable text form.
   * Used for the title field in <a> tags.
   * @return string the text, including any prefixes
   */
  public function getEscapedText() {
    return htmlspecialchars( $this->getPrefixedText() );
  }

  /**
   * Get a URL with no fragment or server name.  If this page is generated
   * with action=render, $wgServer is prepended.
   * @param string $query an optional query string; if not specified,
   *   $wgArticlePath will be used.
   * @param string $variant language variant of url (for sr, zh..)
   * @return string the URL
   */
  public function getLocalURL( $query = '', $variant = FALSE ) {
    global $wgArticlePath, $wgScript, $wgServer, $wgRequest;
    global $wgVariantArticlePath, $wgContLang, $wgUser;

    // internal links should point to same variant as current page (only anonymous users)
    if($variant == FALSE && $wgContLang->hasVariants() && !$wgUser->isLoggedIn()){
      $pref = $wgContLang->getPreferredVariant(FALSE);
      if($pref != $wgContLang->getCode())
        $variant = $pref;
    }

    if ( $this->isExternal() ) {
      $url = $this->getFullURL();
      if ( $query ) {
        // This is currently only used for edit section links in the
        // context of interwiki transclusion. In theory we should
        // append the query to the end of any existing query string,
        // but interwiki transclusion is already broken in that case.
        $url .= "?$query";
      }
    } else {
      $dbkey = wfUrlencode( $this->getPrefixedDBkey() );
      if ( $query == '' ) {
        if($variant!=FALSE && $wgContLang->hasVariants()){
          if($wgVariantArticlePath==FALSE) {
            $variantArticlePath =  "$wgScript?title=$1&variant=$2"; // default
          } else {
            $variantArticlePath = $wgVariantArticlePath;
          }
          $url = str_replace( '$2', urlencode( $variant ), $variantArticlePath );
          $url = str_replace( '$1', $dbkey, $url  );
        }
        else {
          $url = str_replace( '$1', $dbkey, $wgArticlePath );
        }
      } else {
        global $wgActionPaths;
        $url = FALSE;
        $matches = array();
        if( !empty( $wgActionPaths ) &&
          preg_match( '/^(.*&|)action=([^&]*)(&(.*)|)$/', $query, $matches ) )
        {
          $action = urldecode( $matches[2] );
          if( isset( $wgActionPaths[$action] ) ) {
            $query = $matches[1];
            if( isset( $matches[4] ) ) $query .= $matches[4];
            $url = str_replace( '$1', $dbkey, $wgActionPaths[$action] );
            if( $query != '' ) $url .= '?' . $query;
          }
        }
        if ( $url === FALSE ) {
          if ( $query == '-' ) {
            $query = '';
          }
          $url = "{$wgScript}?title={$dbkey}&{$query}";
        }
      }
      
      // FIXME: this causes breakage in various places when we
      // actually expected a local URL and end up with dupe prefixes.
// TODO: For Drupal we always render, no matter what
//      if ($wgRequest->getVal('action') == 'render') {
        $url = $wgServer . $url;
//      }
    }
    wfRunHooks( 'GetLocalURL', array( &$this, &$url, $query ) );
    return $url;
  }

  /**
   * Get a real URL referring to this title, with interwiki link and
   * fragment
   *
   * @param string $query an optional query string, not used
   *   for interwiki links
   * @param string $variant language variant of url (for sr, zh..)
   * @return string the URL
   */
  public function getFullURL( $query = '', $variant = FALSE ) {
    global $wgContLang, $wgServer, $wgRequest;

    if ( '' == $this->mInterwiki ) {
      $url = $this->getLocalUrl( $query, $variant );

      // Ugly quick hack to avoid duplicate prefixes (bug 4571 etc)
      // Correct fix would be to move the prepending elsewhere.
/*      if ($wgRequest->getVal('action') != 'render') {
        $url = $wgServer . $url;
      }*/
    } else {
      $baseUrl = $this->getInterwikiLink( $this->mInterwiki );

      $namespace = wfUrlencode( $this->getNsText() );
      if ( '' != $namespace ) {
        # Can this actually happen? Interwikis shouldn't be parsed.
        # Yes! It can in interwiki transclusion. But... it probably shouldn't.
        $namespace .= ':';
      }
      $url = str_replace( '$1', $namespace . $this->mUrlform, $baseUrl );
      $url = wfAppendQuery( $url, $query );
    }

    # Finally, add the fragment.
    $url .= $this->getFragmentForURL();

    wfRunHooks( 'GetFullURL', array( &$this, &$url, $query ) );
    return $url;
  }

  public function getPrefixedURL() {
    $s = $this->prefix( $this->mDbkeyform );
    $s = str_replace( ' ', '_', $s );

    $s = wfUrlencode ( $s ) ;

    # Cleaning up URL to make it look nice -- is this safe?
    $s = str_replace( '%28', '(', $s );
    $s = str_replace( '%29', ')', $s );

    return $s;
  }


  /**
   * Is this Title interwiki?
   * @return boolean
   */
  public function isExternal() { return ( '' != $this->mInterwiki ); }

  /**
   * Do we know that this title definitely exists, or should we otherwise
   * consider that it exists?
   *
   * @return bool
   */
  public function isAlwaysKnown() {
    return $this->isExternal()
            || ( $this->mNamespace == NS_MAIN && $this->mDbkeyform == '' )
            || ( $this->mNamespace == NS_MEDIAWIKI && wfMsgWeirdKey( $this->mDbkeyform ) );
  }

  /**
   * Returns the URL associated with an interwiki prefix
   * @param string $key the interwiki prefix (e.g. "MeatBall")
   * @return the associated URL, containing "$1", which should be
   *   replaced by an article title
   * @static (arguably)
   */
  public function getInterwikiLink( $key )  {
    global $wgMemc, $wgInterwikiExpiry;
    global $wgInterwikiCache, $wgContLang;
    $fname = 'Title::getInterwikiLink';
    $key = $wgContLang->lc( $key );
    // TODO: implement interwiki links
    return mediawiki_filter_get_interwiki_url($key);

    $k = wfMemcKey( 'interwiki', $key );
    if( array_key_exists( $k, Title::$interwikiCache ) ) {
      return Title::$interwikiCache[$k]->iw_url;
    }

    if ($wgInterwikiCache) {
      return Title::getInterwikiCached( $key );
    }

    $s = $wgMemc->get( $k );
    # Ignore old keys with no iw_local
    if( $s && isset( $s->iw_local ) && isset($s->iw_trans)) {
      Title::$interwikiCache[$k] = $s;
      return $s->iw_url;
    }

    $dbr = wfGetDB( DB_SLAVE );
    $res = $dbr->select( 'interwiki',
      array( 'iw_url', 'iw_local', 'iw_trans' ),
      array( 'iw_prefix' => $key ), $fname );
    if( !$res ) {
      return '';
    }

    $s = $dbr->fetchObject( $res );
    if( !$s ) {
      # Cache non-existence: create a blank object and save it to memcached
      $s = (object)FALSE;
      $s->iw_url = '';
      $s->iw_local = 0;
      $s->iw_trans = 0;
    }
    $wgMemc->set( $k, $s, $wgInterwikiExpiry );
    Title::$interwikiCache[$k] = $s;

    return $s->iw_url;
  }


  /**
   * Escape a text fragment, say from a link, for a URL
   */
  static function escapeFragmentForURL( $fragment ) {
    $fragment = str_replace( ' ', '_', $fragment );
    $fragment = urlencode( Sanitizer::decodeCharReferences( $fragment ) );
    $replaceArray = array(
      '%3A' => ':',
      '%' => '.'
    );
    return strtr( $fragment, $replaceArray );
  }

}

/**
 * Dummy linker class
 * TODO: Major cleanup
 */
class Linker {

  function makeExternalLink( $url, $text, $escape = TRUE, $linktype = '', $ns = NULL ) {
    printLine("makeExternalLink($url, $text, $escape)");
    $style = $this->getExternalLinkAttributes( $url, $text, 'external ' . $linktype );
    $url = htmlspecialchars( $url );
    if( $escape ) {
      $text = htmlspecialchars( $text );
    }
    return '<a href="'.$url.'"'.$style.'>'.$text.'</a>';
  }

  /** @todo document */
  function tocIndent() {
    return "\n<ul>";
  }

  /** @todo document */
  function tocUnindent($level) {
    return "</li>\n" . str_repeat( "</ul>\n</li>\n", $level>0 ? $level : 0 );
  }

  /**
   * parameter level defines if we are on an indentation level
   */
  function tocLine( $anchor, $tocline, $tocnumber, $level ) {
    return "\n<li class=\"toclevel-$level\"><a href=\"#" .
      $anchor . '"><span class="tocnumber">' .
      $tocnumber . '</span> <span class="toctext">' .
      $tocline . '</span></a>';
  }

  /** @todo document */
  function tocLineEnd() {
    return "</li>\n";
  }

  /** @todo document */
  function tocList($toc) {
    global $wgJsMimeType;
    $title =  wfMsgHtml('toc') ;
    return
       '<table id="toc" class="toc" summary="' . $title .'"><tr><td>'
     . '<div id="toctitle"><strong>' . $title . "</strong></div>\n<div id=\"tocbody\">"
     . $toc
     # no trailing newline, script should not be wrapped in a
     # paragraph
     . "</ul></div>\n</td></tr></table>";
/*     . '<script type="' . $wgJsMimeType . '">'
     . ' if (window.showTocToggle) {'
     . ' var tocShowText = "' . wfEscapeJsString( wfMsg('showtoc') ) . '";'
     . ' var tocHideText = "' . wfEscapeJsString( wfMsg('hidetoc') ) . '";'
     . ' showTocToggle();'
     . ' } '
     . "</script>\n";*/
  }


  function makeHeadline( $level, $attribs, $anchor, $text, $link ) {
    return "<a name=\"$anchor\"></a><h$level$attribs$link <span class=\"mw-headline\">$text</span></h$level>";
  }

  /**
   * @param $nt Title object.
   * @param $section Integer: section number.
   * @param $hint Link String: title, or default if omitted or empty
   */
  public function editSectionLink( Title $nt, $section, $hint='' ) {
    // No edit section links provided (yet)
    return '';
  }

  function makeLinkObj( $nt, $text= '', $query = '', $trail = '', $prefix = '' ) {
    global $wgUser;
    $fname = 'Linker::makeLinkObj';
    wfProfileIn( $fname );

    # Fail gracefully
    if ( ! is_object($nt) ) {
      # throw new MWException();
      wfProfileOut( $fname );
      return "<!-- ERROR -->{$prefix}{$text}{$trail}";
    }

    if ( $nt->isExternal() ) {
      $u = $nt->getFullURL();
      $link = $nt->getPrefixedURL();
      if ( '' == $text ) { $text = $nt->getPrefixedText(); }
      $style = $this->getInterwikiLinkAttributes( $link, $text, 'extiw' );

      $inside = '';
      if ( '' != $trail ) {
        $m = array();
        if ( preg_match( '/^([a-z]+)(.*)$$/sD', $trail, $m ) ) {
          $inside = $m[1];
          $trail = $m[2];
        }
      }
      $t = "<a href=\"{$u}\"{$style}>{$text}{$inside}</a>";

      wfProfileOut( $fname );
      return $t;
    } elseif ( $nt->isAlwaysKnown() ) {
      # Image links, special page links and self-links with fragements are always known.
      $retVal = $this->makeKnownLinkObj( $nt, $text, $query, $trail, $prefix );
    } else {
      wfProfileIn( $fname.'-immediate' );

      # Handles links to special pages wich do not exist in the database:
      if( $nt->getNamespace() == NS_SPECIAL ) {
        if( SpecialPage::exists( $nt->getDbKey() ) ) {
          $retVal = $this->makeKnownLinkObj( $nt, $text, $query, $trail, $prefix );
        } else {
          $retVal = $this->makeBrokenLinkObj( $nt, $text, $query, $trail, $prefix );
        }
        wfProfileOut( $fname.'-immediate' );
        wfProfileOut( $fname );
        return $retVal;
      }

      # Work out link colour immediately
      $aid = $nt->getArticleID() ;
      if ( 0 == $aid ) {
        $retVal = $this->makeBrokenLinkObj( $nt, $text, $query, $trail, $prefix );
      } else {
        $stub = false;
        if ( $nt->isContentPage() ) {
          $threshold = $wgUser->getOption('stubthreshold');
          if ( $threshold > 0 ) {
            $dbr = wfGetDB( DB_SLAVE );
            $s = $dbr->selectRow(
              array( 'page' ),
              array( 'page_len',
                     'page_is_redirect' ),
              array( 'page_id' => $aid ), $fname ) ;
            $stub = ( $s !== false && !$s->page_is_redirect &&
                $s->page_len < $threshold );
          }
        }
        if ( $stub ) {
          $retVal = $this->makeStubLinkObj( $nt, $text, $query, $trail, $prefix );
        } else {
          $retVal = $this->makeKnownLinkObj( $nt, $text, $query, $trail, $prefix );
        }
      }
      wfProfileOut( $fname.'-immediate' );
    }
    wfProfileOut( $fname );
    return $retVal;
  }


  /**
   * Make a link for a title which definitely exists. This is faster than makeLinkObj because
   * it doesn't have to do a database query. It's also valid for interwiki titles and special
   * pages.
   *
   * @param $nt Title object of target page
   * @param $text   String: text to replace the title
   * @param $query  String: link target
   * @param $trail  String: text after link
   * @param $prefix String: text before link text
   * @param $aprops String: extra attributes to the a-element
   * @param $style  String: style to apply - if empty, use getInternalLinkAttributesObj instead
   * @return the a-element
   */
  function makeKnownLinkObj( $nt, $text = '', $query = '', $trail = '', $prefix = '' , $aprops = '', $style = '' ) {

    $fname = 'Linker::makeKnownLinkObj';
    wfProfileIn( $fname );

    if ( !is_object( $nt ) ) {
      wfProfileOut( $fname );
      return $text;
    }

    $u = $nt->escapeLocalURL( $query );
    if ( $nt->getFragment() != '' ) {
      if( $nt->getPrefixedDbkey() == '' ) {
        $u = '';
        if ( '' == $text ) {
          $text = htmlspecialchars( $nt->getFragment() );
        }
      }
      $u .= $nt->getFragmentForURL();
    }
    if ( $text == '' ) {
      $text = htmlspecialchars( $nt->getPrefixedText() );
    }
    if ( $style == '' ) {
      $style = $this->getInternalLinkAttributesObj( $nt, $text );
    }

    if ( $aprops !== '' ) $aprops = ' ' . $aprops;

    list( $inside, $trail ) = Linker::splitTrail( $trail );
    $r = "<a href=\"{$u}\"{$style}{$aprops}>{$prefix}{$text}{$inside}</a>{$trail}";
    wfProfileOut( $fname );

    return $r;
  }

  /**
   * Make a red link to the edit page of a given title.
   * 
   * @param $title String: The text of the title
   * @param $text  String: Link text
   * @param $query String: Optional query part
   * @param $trail String: Optional trail. Alphabetic characters at the start of this string will
   *                      be included in the link text. Other characters will be appended after
   *                      the end of the link.
   */
  function makeBrokenLinkObj( $nt, $text = '', $query = '', $trail = '', $prefix = '' ) {

    # Fail gracefully
    if ( ! isset($nt) ) {
      # throw new MWException();
      return "<!-- ERROR -->{$prefix}{$text}{$trail}";
    }

    $fname = 'Linker::makeBrokenLinkObj';
    wfProfileIn( $fname );

    if( $nt->getNamespace() == NS_SPECIAL ) {
      $q = $query;
    } else if ( '' == $query ) {
      $q = 'action=edit';
    } else {
      $q = 'action=edit&'.$query;
    }
//    $u = $nt->escapeLocalURL( $q );
    $u = mediawiki_filter_get_create_url($nt->getText(), $nt->getNamespace(), $q);

    if ( '' == $text ) {
      $text = htmlspecialchars( $nt->getPrefixedText() );
    }
    $style = $this->getInternalLinkAttributesObj( $nt, $text, "yes" );

    list( $inside, $trail ) = Linker::splitTrail( $trail );
    $s = "<a href=\"{$u}\"{$style}>{$prefix}{$text}{$inside}</a>{$trail}";

    wfProfileOut( $fname );
    return $s;
  }

  /**
   * Create a direct link to a given uploaded file.
   *
   * @param $title Title object.
   * @param $text  String: pre-sanitized HTML
   * @return string HTML
   *
   * @public
   * @todo Handle invalid or missing images better.
   */
  function makeMediaLinkObj( $title, $text = '' ) {
    if( is_NULL( $title ) ) {
      ### HOTFIX. Instead of breaking, return empty string.
      return $text;
    } else {
      $img  = wfFindFile( $title );
      if( $img ) {
        $url  = $img->getURL();
        $class = 'internal';
      } else {
        $upload = SpecialPage::getTitleFor( 'Upload' );
        $url = $upload->getLocalUrl( 'wpDestFile=' . urlencode( $title->getDbKey() ) );
        $class = 'new';
      }
      $alt = htmlspecialchars( $title->getText() );
      if( $text == '' ) {
        $text = $alt;
      }
      $u = htmlspecialchars( $url );
      return "<a href=\"{$u}\" class=\"$class\" title=\"{$alt}\">{$text}</a>";
    }
  }

  /**
   * Make a "broken" link to an image
   *
   * @param Title $title Image title
   * @param string $text Link label
   * @param string $query Query string
   * @param string $trail Link trail
   * @param string $prefix Link prefix
   * @return string
   */
  public function makeBrokenImageLinkObj( $title, $text = '', $query = '', $trail = '', $prefix = '' ) {
    if( $title instanceof Title ) {
      wfProfileIn( __METHOD__ );
      if (node_access('create', 'image')) {
        if( $text == '' ) {
          $text = htmlspecialchars( $title->getPrefixedText() );
        }
        list( $inside, $trail ) = self::splitTrail( $trail );
        $style = $this->getInternalLinkAttributesObj( $title, $text, 'yes' );
        wfProfileOut( __METHOD__ );
        return '<a href="' . mediawiki_filter_get_create_url($title->getText(), NS_IMAGE) . '"'
          . $style . '>' . $prefix . $text . $inside . '</a>' . $trail;
      } else {
        wfProfileOut( __METHOD__ );
        return $this->makeKnownLinkObj( $title, $text, $query, $trail, $prefix );
      }
    } else {
      return "<!-- ERROR -->{$prefix}{$text}{$trail}";
    }
  }

  /**
   * Make an image link
   * @param Title $title Title object
   * @param File $file File object, or FALSE if it doesn't exist
   *
   * @param array $frameParams Associative array of parameters external to the media handler.
   *     Boolean parameters are indicated by presence or absence, the value is arbitrary and 
   *     will often be FALSE.
   *          thumbnail       If present, downscale and frame
   *          manualthumb     Image name to use as a thumbnail, instead of automatic scaling
   *          framed          Shows image in original size in a frame
   *          frameless       Downscale but don't frame
   *          upright         If present, tweak default sizes for portrait orientation
   *          upright_factor  Fudge factor for "upright" tweak (default 0.75)
   *          border          If present, show a border around the image
   *          align           Horizontal alignment (left, right, center, none)
   *          valign          Vertical alignment (baseline, sub, super, top, text-top, middle, 
   *                          bottom, text-bottom)
   *          alt             Alternate text for image (i.e. alt attribute). Plain text.
   *          caption         HTML for image caption.
   *
   * @param array $handlerParams Associative array of media handler parameters, to be passed 
   *       to transform(). Typical keys are "width" and "page". 
   */
  function makeImageLink2( Title $title, $file, $frameParams = array(), $handlerParams = array() ) {
  
    global $wgContLang, $wgUser, $wgThumbLimits, $wgThumbUpright;
    if ( $file && !$file->allowInlineDisplay() ) {
      wfDebug( __METHOD__.': '.$title->getPrefixedDBkey()." does not allow inline display\n" );
      return $this->makeKnownLinkObj( $title );
    }

    // Shortcuts
    $fp =& $frameParams;
    $hp =& $handlerParams;

    // Clean up parameters
    $page = isset( $hp['page'] ) ? $hp['page'] : FALSE;
    if ( !isset( $fp['align'] ) ) $fp['align'] = '';
    if ( !isset( $fp['alt'] ) ) $fp['alt'] = '';

    $prefix = $postfix = '';

    if ( 'center' == $fp['align'] )
    {
      $prefix  = '<div class="center">';
      $postfix = '</div>';
      $fp['align']   = 'none';
    }
    if ( $file && !isset( $hp['width'] ) ) {
      $hp['width'] = $file->getWidth( $page );

      if( isset( $fp['thumbnail'] ) || isset( $fp['framed'] ) || isset( $fp['frameless'] ) || !$hp['width'] ) {
        $wopt = $wgUser->getOption( 'thumbsize' );

        if( !isset( $wgThumbLimits[$wopt] ) ) {
           $wopt = User::getDefaultOption( 'thumbsize' );
        }

        // Reduce width for upright images when parameter 'upright' is used
        if ( isset( $fp['upright'] ) && $fp['upright'] == 0 ) {
          $fp['upright'] = $wgThumbUpright;
        }
        // Use width which is smaller: real image width or user preference width
        // For caching health: If width scaled down due to upright parameter, round to full __0 pixel to avoid the creation of a lot of odd thumbs
        $prefWidth = isset( $fp['upright'] ) ? 
          round( $wgThumbLimits[$wopt] * $fp['upright'], -1 ) : 
          $wgThumbLimits[$wopt];
        if ( $hp['width'] <= 0 || $prefWidth < $hp['width'] ) {
          $hp['width'] = $prefWidth;
        }
      }
    }

    if ( isset( $fp['thumbnail'] ) || isset( $fp['manualthumb'] ) || isset( $fp['framed'] ) ) {

      # Create a thumbnail. Alignment depends on language
      # writing direction, # right aligned for left-to-right-
      # languages ("Western languages"), left-aligned
      # for right-to-left-languages ("Semitic languages")
      #
      # If  thumbnail width has not been provided, it is set
      # to the default user option as specified in Language*.php
      if ( $fp['align'] == '' ) {
        $fp['align'] = $wgContLang->isRTL() ? 'left' : 'right';
      }
      return $prefix.$this->makeThumbLink2( $title, $file, $fp, $hp ).$postfix;
    }

    if ( $file && $hp['width'] ) {
      # Create a resized image, without the additional thumbnail features
      $thumb = $file->transform( $hp );
    } else {
      $thumb = FALSE;
    }

    if ( !$thumb ) {
      $s = $this->makeBrokenImageLinkObj( $title );
    } else {
      $s = $thumb->toHtml( array(
        'desc-link' => TRUE,
        'alt' => $fp['alt'],
        'valign' => isset( $fp['valign'] ) ? $fp['valign'] : FALSE ,
        'img-class' => isset( $fp['border'] ) ? 'thumbborder' : FALSE ) );
    }
    if ( '' != $fp['align'] ) {
      $s = "<div class=\"float{$fp['align']}\"><span>{$s}</span></div>";
    }
    return str_replace("\n", ' ',$prefix.$s.$postfix);
  }

  function makeThumbLink2( Title $title, $file, $frameParams = array(), $handlerParams = array() ) {
    global $wgStylePath, $wgContLang;
    $exists = $file && $file->exists();

    # Shortcuts
    $fp =& $frameParams;
    $hp =& $handlerParams;

    $page = isset( $hp['page'] ) ? $hp['page'] : FALSE;
    if ( !isset( $fp['align'] ) ) $fp['align'] = 'right';
    if ( !isset( $fp['alt'] ) ) $fp['alt'] = '';
    if ( !isset( $fp['caption'] ) ) $fp['caption'] = '';

    if ( empty( $hp['width'] ) ) {
      // Reduce width for upright images when parameter 'upright' is used 
      $hp['width'] = mediawiki_filter_thumbnail_size(isset($fp['upright']));
    }
    $thumb = FALSE;

    if ( !$exists ) {
      $outerWidth = $hp['width'] + 2;
    } else {
      if ( isset( $fp['manualthumb'] ) ) {
        # Use manually specified thumbnail
        $manual_title = Title::makeTitleSafe( NS_IMAGE, $fp['manualthumb'] );
        if( $manual_title ) {
          $manual_img = wfFindFile( $manual_title );
          if ( $manual_img ) {
            $thumb = $manual_img->getUnscaledThumb();
          } else {
            $exists = FALSE;
          }
        }
      } elseif ( isset( $fp['framed'] ) ) {
        // Use image dimensions, don't scale
        $thumb = $file->getUnscaledThumb( $page );
      } else {
        # Do not present an image bigger than the source, for bitmap-style images
        # This is a hack to maintain compatibility with arbitrary pre-1.10 behaviour
        $srcWidth = $file->getWidth( $page );
        if ( $srcWidth && !$file->mustRender() && $hp['width'] > $srcWidth ) {
          $hp['width'] = $srcWidth;
        }
        $thumb = $file->transform( $hp );
      }

      if ( $thumb ) {
        $outerWidth = $thumb->getWidth() + 2;
      } else {
        $outerWidth = $hp['width'] + 2;
      }
    }

    $more = htmlspecialchars( wfMsg( 'thumbnail-more' ) );
    $magnifyalign = $wgContLang->isRTL() ? 'left' : 'right';
    $textalign = $wgContLang->isRTL() ? ' style="text-align:right"' : '';

    $s = "<div class=\"thumb t{$fp['align']}\"><div class=\"thumbinner\" style=\"width:{$outerWidth}px;\">";
    if( !$exists ) {
      $s .= $this->makeBrokenImageLinkObj( $title );
      $zoomicon = '';
    } elseif ( !$thumb ) {
      $s .= htmlspecialchars( wfMsg( 'thumbnail_error', '' ) );
      $zoomicon = '';
    } else {
      $s .= $thumb->toHtml( array(
        'alt' => $fp['alt'],
        'img-class' => 'thumbimage',
        'desc-link' => TRUE ) );
      if ( isset( $fp['framed'] ) ) {
        $zoomicon="";
      } else {
        $url = $file->getImageURL();
        $zoomicon =  '<div class="magnify" style="float:'.$magnifyalign.'">'.
          '<a href="'.$url.'" class="internal" title="'.$more.'">'.
          //'<img src="'.$wgStylePath.'/common/images/magnify-clip.png" ' .
          //'width="15" height="11" alt="" /></a></div>';
          '<strong>+</strong></a></div>';
      }
    }
    $s .= '  <div class="thumbcaption"'.$textalign.'>'.$zoomicon.$fp['caption']."</div></div></div>";
    return str_replace("\n", ' ', $s);
  }


  /** @todo document */
  function fnamePart( $url ) {
    $basename = strrchr( $url, '/' );
    if ( false === $basename ) {
      $basename = $url;
    } else {
      $basename = substr( $basename, 1 );
    }
    return htmlspecialchars( $basename );
  }

  /** @todo document */
  function makeExternalImage( $url, $alt = '' ) {
    if ( '' == $alt ) {
      $alt = $this->fnamePart( $url );
    }
    $s = '<img src="'.$url.'" alt="'.$alt.'" />';
    return $s;
  }

  /**
   * Split a link trail, return the "inside" portion and the remainder of the trail
   * as a two-element array
   */
  static function splitTrail( $trail ) {
    static $regex = FALSE;
    if ( $regex === FALSE ) {
      global $wgContLang;
      $regex = $wgContLang->linkTrail();
    }
    $inside = '';
    if ( '' != $trail ) {
      $m = array();
      if ( preg_match( $regex, $trail, $m ) ) {
        $inside = $m[1];
        $trail = $m[2];
      }
    }
    return array( $inside, $trail );
  }

  /**
   * @param $broken 'stub' or 'yes' or FALSE
   */
  function getInternalLinkAttributesObj( &$nt, $text, $broken = FALSE ) {
    if( $broken == 'stub' ) {
      $r = ' class="stub"';
    } else if ( $broken == 'yes' ) {
      $r = ' class="newwiki"';
    } else {
      $r = '';
    }

    $r .= ' title="' . $nt->getEscapedText() . '"';
    return $r;
  }

  function getInterwikiLinkAttributes( $link, $text, $class='' ) {
    global $wgContLang;

    $link = urldecode( $link );
    $link = $wgContLang->checkTitleEncoding( $link );
    $link = preg_replace( '/[\\x00-\\x1f]/', ' ', $link );
    $link = htmlspecialchars( $link );

    $r = ($class != '') ? " class=\"$class\"" : " class=\"external\"";
    $r .= " title=\"{$link}\"";
    return $r;
  }

  function getExternalLinkAttributes( $link, $text, $class='' ) {
    $link = htmlspecialchars( $link );
    $r = ($class != '') ? " class=\"$class\"" : " class=\"external\"";
    $r .= " title=\"{$link}\"";
    return $r;
  }

}

/**
 * Abstraction of an 'image' node of the image module.
 */
class DrupalImageFile {

  var $node;

  function __construct($title) {
    $type = mediawiki_filter_node_type_for_namespace($title->getNamespace());
    $result = db_query("SELECT nid,vid FROM {node} WHERE type = '%s' AND LOWER(title) = '%s'", $type, strtolower($title->getText()));
    if ($row = db_fetch_object($result)) {
      if (db_fetch_object($result)) {
        // TODO: do some more elaborate stuff
        drupal_set_message(t('Found mutliple images with name %title. Using <a href="!url">first match</a> for current page.', array('%title' => $title, '!url' => url('node/'.$row->nid))));
      }
      $this->node = node_load($row->nid);
      $this->info = image_get_info(file_create_path($this->node->images[IMAGE_ORIGINAL]));
    }
    else {
      $this->node = NULL;
    }
  }

  function exists() {
    return !is_null($this->node);
  }

  function getTitle() {
    return $node->title;
  }

  function getHandler() {
    return new DrupalImageFileHandler;
  }

  function allowInlineDisplay() {
    return TRUE;
  }

  function getWidth() {
    return $this->info['width'];
  }

  function mustRender() {
    return FALSE;
  }

  function getImageURL() {
    return $url = url('node/' . $this->node->nid);
  }

  /**
   * Transform a media file
   *
   * @param array $params An associative array of handler-specific parameters. Typical 
   *                      keys are width, height and page.
   * @param integer $flags A bitfield, may contain self::RENDER_NOW to force rendering
   * @return MediaTransformOutput
   */
  function transform( $params, $flags = 0 ) {
    if (!$this->exists()) {
      return FALSE;
    }

    if (module_exists('image')) {
      $image_sizes = _image_get_sizes();
      $image_sizes[] = array(
        'label' => IMAGE_ORIGINAL,
        'width' => $this->info['width'],
        'height' => $this->info['height'],
      );
      // TODO: check if 'image_sizes' is sorted according to width/height
    }
    else {
      $image_sizes = array();
    }
    if (isset($params['width'])) {
      foreach($image_sizes as $image_label => $image_size) {
        if ($image_size['width'] >= $params['width']) {
          break;
        }
      }
    }
/*    $upright = $this->info['width'] < $this->info['height'];
    foreach($image_sizes as $image_label => $image_size) {
      if ($upright) {
        if ($image_size['height'] >= $params['height']) {
          break;
        }
      }
      else {
        if ($image_size['width'] >= $params['width']) {
          break;
        }
      }
    }*/

    if (!$image_label) {
      $image_label = IMAGE_ORIGINAL;
    }
    wfProfileIn( __METHOD__ );
    $path = file_create_path($this->node->images[$image_label]);
    $url = url($this->node->images[$image_label]);

    $thumb = new DrupalImageTransformOutput($this, $url, $path, $params['width'], $params['height']);

    wfProfileOut( __METHOD__ );
    return $thumb;
  }

  function getUnscaledThumb()
  {
    return $this->transform(array('width' => $this->info['width']));
  }
}

/**
 * Image file handler dummy.
 */
class DrupalImageFileHandler {
  function getParamMap() {
    return array('img_width' => 'width');
  }

  function validateParam( $name, $value ) {
    if ( in_array( $name, array( 'width', 'height' ) ) ) {
      if ( $value <= 0 ) {
        return FALSE;
      } else {
        return TRUE;
      }
    } else {
      return FALSE;
    }
  }

  function parserTransformHook( $parser, $file ) {}
}

/**
 * Abstraction of an 'image' attachment of a certain size.
 */
class DrupalImageTransformOutput {

  var $file, $width, $height, $url, $page, $path;

  function __construct($file, $url, $path, $width, $height) {
    $this->file = $file;
    $this->url = $url;
    $this->path = $path;
    $this->width = $width;
    $this->height = $height;
  }

  /**
   * Get the width of the output box
   */
  function getWidth() {
    return $this->width;
  }

  /**
   * Get the height of the output box
   */
  function getHeight() {
    return $this->height;
  }

  /**
   * @return string The thumbnail URL
   */
  function getUrl() {
    return $this->url;
  }

  /**
   * @return string Destination file path (local filesystem)
   */
  function getPath() {
    return $this->path;
  }

  /**
   * Return HTML <img ... /> tag for the thumbnail, will include
   * width and height attributes and a blank alt text (as required).
   * 
   * @param array $options Associative array of options. Boolean options 
   *     should be indicated with a value of TRUE for TRUE, and FALSE or 
   *     absent for FALSE.
   *
   *     alt          Alternate text or caption
   *     desc-link    Boolean, show a description link
   *     file-link    Boolean, show a file download link
   *     valign       vertical-align property, if the output is an inline element
   *     img-class    Class applied to the <img> tag, if there is such a tag
   *
   * For images, desc-link and file-link are implemented as a click-through. For 
   * sounds and videos, they may be displayed in other ways. 
   *
   * @return string
   * @public
   */
  function toHtml( $options = array() ) {
    if ( count( func_get_args() ) == 2 ) {
      throw new MWException( __METHOD__ .' called in the old style' );
    }

    $alt = empty( $options['alt'] ) ? '' : $options['alt'];
    if ( !empty( $options['desc-link'] ) ) {
      $linkAttribs = $this->getDescLinkAttribs( $alt );
    } elseif ( !empty( $options['file-link'] ) ) {
      $linkAttribs = array( 'href' => $this->file->getURL() );
    } else {
      $linkAttribs = FALSE;
    }

    $attribs = array(
      'alt' => $alt,
      'src' => $this->url,
      'width' => $this->width,
      'height' => $this->height,
      'border' => 0,
    );
    if ( !empty( $options['valign'] ) ) {
      $attribs['style'] = "vertical-align: {$options['valign']}";
    }
    if ( !empty( $options['img-class'] ) ) {
      $attribs['class'] = $options['img-class'];
    }
    return $this->linkWrap( $linkAttribs, Xml::element( 'img', $attribs ) );
  }

  /**
   * This will be overridden to return TRUE in error classes
   */
  function isError() {
    return FALSE;
  }

  /**
   * Wrap some XHTML text in an anchor tag with the given attributes
   */
  protected function linkWrap( $linkAttribs, $contents ) {
    if ( $linkAttribs ) {
      return Xml::tags( 'a', $linkAttribs, $contents );
    } else {
      return $contents;
    }
  }

  function getDescLinkAttribs( $alt = FALSE ) {
    $query = $this->page ? ( 'page=' . urlencode( $this->page ) ) : '';
    $title = $this->file->getTitle();
    if ( strval( $alt ) === '' ) {
      $alt = $title;
    }
    return array( 
      'href' => url('node/'.$this->file->node->nid),
      'class' => 'image',
      'title' => $alt
    );
  }

}

/*
 * PHP error prevention...
 */
class DummyStub {
  function __call($name, $arguments) {
    drupal_set_message(t("Non-existing function %name called. Please report this error to the maintainer.", array('%name' => $name)), ERROR);
    return NULL;
  }
}
