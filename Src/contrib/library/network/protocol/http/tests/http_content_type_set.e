note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	HTTP_CONTENT_TYPE_SET

inherit
	EQA_TEST_SET

feature -- Content type

	test_http_content_type
		local
			ct: HTTP_CONTENT_TYPE
		do
			test_content_type ("application/atom+xml", "application", "atom+xml") -- Atom feeds
			test_content_type ("application/ecmascript", "application", "ecmascript") -- ECMAScript/JavaScript; Defined in RFC 4329 (equivalent to application/javascript but with stricter processing rules)
			test_content_type ("application/EDI-X12", "application", "EDI-X12") -- EDI X12 data; Defined in RFC 1767
			test_content_type ("application/EDIFACT", "application", "EDIFACT") -- EDI EDIFACT data; Defined in RFC 1767
			test_content_type ("application/json", "application", "json") -- JavaScript Object Notation JSON; Defined in RFC 4627
			test_content_type ("application/javascript", "application", "javascript") -- ECMAScript/JavaScript; Defined in RFC 4329 (equivalent to application/ecmascript but with looser processing rules) It is not accepted in IE 8 or earlier - text/javascript is accepted but it is defined as obsolete in RFC 4329. The "type" attribute of the <script> tag in HTML5 is optional. In practice, omitting the media type of JavaScript programs is the most interoperable solution, since all browsers have always assumed the correct default even before HTML5.
			test_content_type ("application/octet-stream", "application", "octet-stream") -- Arbitrary binary data.[10] Generally speaking this type identifies files that are not associated with a specific application. Contrary to past assumptions by software packages such as Apache this is not a type that should be applied to unknown files. In such a case, a server or application should not indicate a content type, as it may be incorrect, but rather, should omit the type in order to allow the recipient to guess the type.[11]
			test_content_type ("application/ogg", "application", "ogg") -- Ogg, a multimedia bitstream container format; Defined in RFC 5334
			test_content_type ("application/pdf", "application", "pdf") -- Portable Document Format, PDF has been in use for document exchange on the Internet since 1993; Defined in RFC 3778
			test_content_type ("application/postscript", "application", "postscript") -- PostScript; Defined in RFC 2046
			test_content_type ("application/rdf+xml", "application", "rdf+xml") -- Resource Description Framework; Defined by RFC 3870
			test_content_type ("application/rss+xml", "application", "rss+xml") -- RSS feeds
			test_content_type ("application/soap+xml", "application", "soap+xml") -- SOAP; Defined by RFC 3902
			test_content_type ("application/font-woff", "application", "font-woff") -- Web Open Font Format; (candidate recommendation; use application/x-font-woff until standard is official)
			test_content_type ("application/xhtml+xml", "application", "xhtml+xml") -- XHTML; Defined by RFC 3236
			test_content_type ("application/xml", "application", "xml") -- XML files; Defined by RFC 3023
			test_content_type ("application/xml-dtd", "application", "xml-dtd") -- DTD files; Defined by RFC 3023
			test_content_type ("application/xop+xml", "application", "xop+xml") -- XOP
			test_content_type ("application/zip", "application", "zip") -- ZIP archive files; Registered[12]
			test_content_type ("application/gzip", "application", "gzip") -- Gzip, Defined in RFC 6713

				-- Type audio
				-- For Audio.
			test_content_type ("audio/basic", "audio", "basic") -- μ-law audio at 8 kHz, 1 channel; Defined in RFC 2046
			test_content_type ("audio/L24", "audio", "L24") -- 24bit Linear PCM audio at 8–48 kHz, 1-N channels; Defined in RFC 3190
			test_content_type ("audio/mp4", "audio", "mp4") -- MP4 audio
			test_content_type ("audio/mpeg", "audio", "mpeg") -- MP3 or other MPEG audio; Defined in RFC 3003
			test_content_type ("audio/ogg", "audio", "ogg") -- Ogg Vorbis, Speex, Flac and other audio; Defined in RFC 5334
			test_content_type ("audio/vorbis", "audio", "vorbis") -- Vorbis encoded audio; Defined in RFC 5215
			test_content_type ("audio/vnd.rn-realaudio", "audio", "vnd.rn-realaudio") -- RealAudio; Documented in RealPlayer Help[13]
			test_content_type ("audio/vnd.wave", "audio", "vnd.wave") -- WAV audio; Defined in RFC 2361
			test_content_type ("audio/webm", "audio", "webm") -- WebM open media format

				-- Type image
			test_content_type ("image/gif", "image", "gif") -- GIF image; Defined in RFC 2045 and RFC 2046
			test_content_type ("image/jpeg", "image", "jpeg") -- JPEG JFIF image; Defined in RFC 2045 and RFC 2046
			test_content_type ("image/pjpeg", "image", "pjpeg") -- JPEG JFIF image; Associated with Internet Explorer; Listed in ms775147(v=vs.85) - Progressive JPEG, initiated before global browser support for progressive JPEGs (Microsoft and Firefox).
			test_content_type ("image/png", "image", "png") -- Portable Network Graphics; Registered,[14] Defined in RFC 2083
			test_content_type ("image/svg+xml", "image", "svg+xml") -- SVG vector image; Defined in SVG Tiny 1.2 Specification Appendix M
			test_content_type ("image/tiff", "image", "tiff") -- Tag Image File Format (only for Baseline TIFF); Defined in RFC 3302

				-- Type message
			test_content_type ("message/http", "message", "http") -- Defined in RFC 2616
			test_content_type ("message/imdn+xml", "message", "imdn+xml") -- IMDN Instant Message Disposition Notification; Defined in RFC 5438
			test_content_type ("message/partial", "message", "partial") -- Email; Defined in RFC 2045 and RFC 2046
			test_content_type ("message/rfc822", "message", "rfc822") -- Email; EML files, MIME files, MHT files, MHTML files; Defined in RFC 2045 and RFC 2046

				-- Type model
				-- For 3D models.
			test_content_type ("model/example", "model", "example") -- Defined in RFC 4735
			test_content_type ("model/iges", "model", "iges") -- IGS files, IGES files; Defined in RFC 2077
			test_content_type ("model/mesh", "model", "mesh") -- MSH files, MESH files; Defined in RFC 2077, SILO files
			test_content_type ("model/vrml", "model", "vrml") -- WRL files, VRML files; Defined in RFC 2077
			test_content_type ("model/x3d+binary", "model", "x3d+binary") -- X3D ISO standard for representing 3D computer graphics, X3DB binary files
			test_content_type ("model/x3d+vrml", "model", "x3d+vrml") -- X3D ISO standard for representing 3D computer graphics, X3DV VRML files
			test_content_type ("model/x3d+xml", "model", "x3d+xml") -- X3D ISO standard for representing 3D computer graphics, X3D XML files

				-- Type multipart
				-- For archives and other objects made of more than one part.
			test_content_type ("multipart/mixed", "multipart", "mixed") -- MIME Email; Defined in RFC 2045 and RFC 2046
			test_content_type ("multipart/alternative", "multipart", "alternative") -- MIME Email; Defined in RFC 2045 and RFC 2046
			test_content_type ("multipart/related", "multipart", "related") -- MIME Email; Defined in RFC 2387 and used by MHTML (HTML mail)
			test_content_type ("multipart/form-data", "multipart", "form-data") -- MIME Webform; Defined in RFC 2388
			test_content_type ("multipart/signed", "multipart", "signed") -- Defined in RFC 1847
			test_content_type ("multipart/encrypted", "multipart", "encrypted") -- Defined in RFC 1847

				-- Type text
				-- For human-readable text and source code.
			test_content_type ("text/cmd", "text", "cmd") -- commands; subtype resident in Gecko browsers like Firefox 3.5
			test_content_type ("text/css", "text", "css") -- Cascading Style Sheets; Defined in RFC 2318
			test_content_type ("text/csv", "text", "csv") -- Comma-separated values; Defined in RFC 4180
			test_content_type ("text/html", "text", "html") -- HTML; Defined in RFC 2854
			test_content_type ("text/javascript", "text", "javascript") -- (Obsolete) JavaScript; Defined in and obsoleted by RFC 4329 in order to discourage its usage in favor of application/javascript. However, text/javascript is allowed in HTML 4 and 5 and, unlike application/javascript, has cross-browser support. The "type" attribute of the <script> tag in HTML5 is optional and there is no need to use it at all since all browsers have always assumed the correct default (even in HTML 4 where it was required by the specification).
			test_content_type ("text/plain", "text", "plain") -- Textual data; Defined in RFC 2046 and RFC 3676
			test_content_type ("text/vcard", "text", "vcard") -- vCard (contact information); Defined in RFC 6350
			test_content_type ("text/xml", "text", "xml") -- Extensible Markup Language; Defined in RFC 3023

				-- Type video
				-- For video.
			test_content_type ("video/mpeg", "video", "mpeg") -- MPEG-1 video with multiplexed audio; Defined in RFC 2045 and RFC 2046
			test_content_type ("video/mp4", "video", "mp4") -- MP4 video; Defined in RFC 4337
			test_content_type ("video/ogg", "video", "ogg") -- Ogg Theora or other video (with audio); Defined in RFC 5334
			test_content_type ("video/quicktime", "video", "quicktime") -- QuickTime video; Registered[15]
			test_content_type ("video/webm", "video", "webm") -- WebM Matroska-based open media format
			test_content_type ("video/x-matroska", "video", "x-matroska") -- Matroska open media format
			test_content_type ("video/x-ms-wmv", "video", "x-ms-wmv") -- Windows Media Video; Documented in Microsoft KB 288102
			test_content_type ("video/x-flv", "video", "x-flv") -- Flash video (FLV files)

				-- List of common media subtype prefixes
				-- Prefix vnd
				-- For vendor-specific files.
			test_content_type ("application/vnd.oasis.opendocument.text", "application", "vnd.oasis.opendocument.text") -- OpenDocument Text; Registered[16]
			test_content_type ("application/vnd.oasis.opendocument.spreadsheet", "application", "vnd.oasis.opendocument.spreadsheet") -- OpenDocument Spreadsheet; Registered[17]
			test_content_type ("application/vnd.oasis.opendocument.presentation", "application", "vnd.oasis.opendocument.presentation") -- OpenDocument Presentation; Registered[18]
			test_content_type ("application/vnd.oasis.opendocument.graphics", "application", "vnd.oasis.opendocument.graphics") -- OpenDocument Graphics; Registered[19]
			test_content_type ("application/vnd.ms-excel", "application", "vnd.ms-excel") -- Microsoft Excel files
			test_content_type ("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application", "vnd.openxmlformats-officedocument.spreadsheetml.sheet") -- Microsoft Excel 2007 files
			test_content_type ("application/vnd.ms-powerpoint", "application", "vnd.ms-powerpoint") -- Microsoft Powerpoint files
			test_content_type ("application/vnd.openxmlformats-officedocument.presentationml.presentation", "application", "vnd.openxmlformats-officedocument.presentationml.presentation") -- Microsoft Powerpoint 2007 files
			test_content_type ("application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application", "vnd.openxmlformats-officedocument.wordprocessingml.document") -- Microsoft Word 2007 files
			test_content_type ("application/vnd.mozilla.xul+xml", "application", "vnd.mozilla.xul+xml") -- Mozilla XUL files
			test_content_type ("application/vnd.google-earth.kml+xml", "application", "vnd.google-earth.kml+xml") -- KML files (e.g. for Google Earth)[20]
			test_content_type ("application/vnd.google-earth.kmz", "application", "vnd.google-earth.kmz") -- KMZ files (e.g. for Google Earth)[21]
			test_content_type ("application/vnd.dart", "application", "vnd.dart") -- Dart files [22]
			test_content_type ("application/vnd.android.package-archive", "application", "vnd.android.package-archive") -- For download apk files.
			test_content_type ("application/vnd.ms-xpsdocument", "application", "vnd.ms-xpsdocument") -- XPS document[23]

				-- Prefix x
				-- For non-standard files. Deprecated by RFC 6648.[2]
			test_content_type ("application/x-7z-compressed", "application", "x-7z-compressed") -- 7-Zip compression format.
			test_content_type ("application/x-deb", "application", "x-deb") -- deb (file format), a software package format used by the Debian project
			test_content_type ("application/x-dvi", "application", "x-dvi") -- device-independent document in DVI format
			test_content_type ("application/x-font-ttf", "application", "x-font-ttf") -- TrueType Font No registered MIME type, but this is the most commonly used
			test_content_type ("application/x-javascript", "application", "x-javascript") --
			test_content_type ("application/x-latex", "application", "x-latex") -- LaTeX files
			test_content_type ("application/x-mpegURL", "application", "x-mpegURL") -- .m3u8 variant playlist
			test_content_type ("application/x-rar-compressed", "application", "x-rar-compressed") -- RAR archive files
			test_content_type ("application/x-shockwave-flash", "application", "x-shockwave-flash") -- Adobe Flash files for example with the extension .swf
			test_content_type ("application/x-stuffit", "application", "x-stuffit") -- StuffIt archive files
			test_content_type ("application/x-tar", "application", "x-tar") -- Tarball files
			test_content_type ("application/x-www-form-urlencoded", "application", "x-www-form-urlencoded") -- Form Encoded Data; Documented in HTML 4.01 Specification, Section 17.13.4.1
			test_content_type ("application/x-xpinstall", "application", "x-xpinstall") -- Add-ons to Mozilla applications (Firefox, Thunderbird, SeaMonkey, and the discontinued Sunbird)
			test_content_type ("audio/x-aac", "audio", "x-aac") -- .aac audio files
			test_content_type ("audio/x-caf", "audio", "x-caf") -- Apple's CAF audio files
			test_content_type ("image/x-xcf", "image", "x-xcf") -- GIMP image file
			test_content_type ("text/x-gwt-rpc", "text", "x-gwt-rpc") -- GoogleWebToolkit data
			test_content_type ("text/x-jquery-tmpl", "text", "x-jquery-tmpl") -- jQuery template data
			test_content_type ("text/x-markdown", "text", "x-markdown") -- Markdown formatted text
			test_content_type ("application/x-pkcs12", "application", "x-pkcs12") -- a variant of PKCS standard files
		end

	test_http_content_type_multipart
		do
			test_content_type_with_params ("multipart/mixed; boundary=%"simple boundary%"", "multipart", "mixed", <<["boundary", "simple boundary"]>>)
			test_content_type_with_params ("multipart/alternative; boundary=boundary42", "multipart", "alternative", <<["boundary", "boundary42"]>>)
			test_content_type_with_params ("multipart/mixed;%N boundary=%"---- main boundary ----%"", "multipart", "mixed", <<["boundary", "---- main boundary ----"]>>)
			test_content_type_with_params ("multipart/digest;%N boundary=%"---- next message ----%"", "multipart", "digest", <<["boundary", "---- next message ----"]>>)

		end

	test_http_content_type_partial
		do
--			     Content-Type: Message/Partial; number=2; total=3;
--                   id="oc=jpbe0M2Yt4s@thumper.bellcore.com"
-- 				 Content-Type: Message/Partial;
--                   id="oc=jpbe0M2Yt4s@thumper.bellcore.com";
--                   number=2
--				 Content-Type: Message/Partial; number=3; total=3;
--                   id="oc=jpbe0M2Yt4s@thumper.bellcore.com"

			test_content_type_with_params ("Message/Partial; number=2; total=3;%N id=%"oc=jpbe0M2Yt4s@thumper.bellcore.com%"", "Message", "Partial", <<["number", "2"], ["total", "3"], ["id", "oc=jpbe0M2Yt4s@thumper.bellcore.com"]>>)
			test_content_type_with_params ("Message/Partial; id=%"oc=jpbe0M2Yt4s@thumper.bellcore.com%";%N number=2", "Message", "Partial", <<["id", "oc=jpbe0M2Yt4s@thumper.bellcore.com"], ["number", "2"] >>)
			test_content_type_with_params ("Message/Partial; number=3; total=3; id=%"oc=jpbe0M2Yt4s@thumper.bellcore.com%";%N", "Message", "Partial", <<["number", "3"], ["total", "3"], ["id", "oc=jpbe0M2Yt4s@thumper.bellcore.com"]>>)

			assert ("Partial is not implemented", True)
		end
feature {NONE} -- Implementation

	test_content_type (a_string: READABLE_STRING_8; a_type, a_subtype: READABLE_STRING_8)
		local
			ct1,ct2: HTTP_CONTENT_TYPE
		do
			create ct1.make_from_string (a_string)
			create ct2.make (a_type, a_subtype)
			assert (a_string, ct1.same_as (ct2))
		end

	test_content_type_with_params (a_string: READABLE_STRING_8; a_type, a_subtype: READABLE_STRING_8; params: detachable ARRAY [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]])
		local
			ct1,ct2: HTTP_CONTENT_TYPE
		do
			create ct1.make_from_string (a_string)
			create ct2.make (a_type, a_subtype)
			if params /= Void then
				across
					params as c
				loop
					ct2.add_parameter (c.item.name, c.item.value)
				end
			end
			assert (a_string, ct1.same_as (ct2))
		end

end

