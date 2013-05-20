note
	description: "[
			Various common MIME types
			
			See also for longer list and description
			http://www.iana.org/assignments/media-types/index.html
			http://www.webmaster-toolkit.com/mime-types.shtml
			
			Please suggest common/popular MIME type which might be missing here
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_MIME_TYPES

feature -- Content type	: application

	application_atom_xml: STRING = "application/atom+xml"
			-- atom application content-type header

	application_force_download: STRING = "application/force-download"

	application_javascript: STRING = "application/javascript"
			-- JavaScript application content-type header

	application_json: STRING = "application/json"
			-- JSON application content-type header

	application_octet_stream: STRING = "application/octet-stream"
			-- Octet stream content-type header

	application_pdf: STRING = "application/pdf"
			-- pdf application content-type header

	application_postscript: STRING = "application/postscript"
			-- postscript application content-type header

	application_rss_xml: STRING = "application/rss+xml"
			-- rss application content-type header

	application_rtf: STRING = "application/rtf"
			-- RTF application content-type header			

	application_xml: STRING = "application/xml"
			-- xml application content-type header

	application_x_shockwave_flash: STRING = "application/x-shockwave-flash"

	application_x_compressed: STRING = "application/x-compressed"

	application_x_gzip: STRING = "application/x-gzip"

	application_zip: STRING = "application/zip"

	application_x_bzip: STRING = "application/x-bzip"

	application_x_bzip2: STRING = "application/x-bzip2"

	application_x_tar: STRING = "application/x-tar"

	application_x_www_form_encoded: STRING = "application/x-www-form-urlencoded"
			-- Starting chars of form url-encoded data content-type header

feature -- Content type	: audio

	audio_mpeg3: STRING = "audio/mpeg3"

	audio_mpeg: STRING = "audio/mpeg"

	audio_wav: STRING = "audio/wav"

feature -- Content type	: image

	image_bmp: STRING = "image/bmp"
			-- BMP image content-type header

	image_gif: STRING = "image/gif"
			-- GIF image content-type header

	image_jpeg: STRING = "image/jpeg"
			-- JPEG image content-type header

	image_jpg: STRING = "image/jpg"
			-- JPEG image content-type header		

	image_png: STRING = "image/png"
			-- PNG image content-type header

	image_svg_xml: STRING = "image/svg+xml"
			-- SVG+XML image content-type header

	image_tiff: STRING = "image/tiff"
			-- TIFF image content-type header	

	image_x_ico: STRING = "image/x-ico"
			-- ICO image content-type header

feature -- Content type	: message

	message_http: STRING = "message/http"
			-- http message content-type header

	message_s_http: STRING = "message/s-http"
			-- s-http message content-type 			

	message_partial: STRING = "message/partial"
			-- partial message content-type

	message_sip: STRING = "message/sip"
			-- sip message content-type

feature -- Content type	: model

	model_vrml: STRING = "model/vrml"

feature -- Content type	: multipart

	multipart_mixed: STRING = "multipart/mixed"

	multipart_alternative: STRING = "multipart/alternative"

	multipart_related: STRING = "multipart/related"

	multipart_form_data: STRING = "multipart/form-data"

	multipart_signed: STRING = "multipart/signed"

	multipart_encrypted: STRING = "multipart/encrypted"

	multipart_x_gzip: STRING = "multipart/x-gzip"

feature -- Content type	: text

	text_css: STRING = "text/css"
			-- CSS text content-type header

	text_csv: STRING = "text/csv"
			-- CSV text content-type header			

	text_html: STRING = "text/html"
			-- HTML text content-type header

	text_javascript: STRING = "text/javascript"
			-- Javascript text content-type header
			-- OBSOLETE

	text_json: STRING = "text/json"
			-- JSON text content-type header

	text_plain: STRING = "text/plain"
			-- Plain text content-type header	

	text_rtf: STRING = "text/rtf"
			-- rtf content-type header	

	text_tab_separated_values: STRING = "text/tab-separated-values"
			-- TSV text content-type header						

	text_xml: STRING = "text/xml"
			-- XML text content-type header

	text_vcard: STRING = "text/vcard"
			-- vcard text content-type header

feature -- Content type	: video	

	video_avi: STRING = "video/avi"

	video_quicktime: STRING = "video/quicktime"

	video_x_motion_jpeg: STRING = "video/x-motion-jpeg"


note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
