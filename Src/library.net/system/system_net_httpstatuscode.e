indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.HttpStatusCode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_NET_HTTPSTATUSCODE

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen accepted: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"202"
		end

	frozen forbidden: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"403"
		end

	frozen length_required: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"411"
		end

	frozen not_implemented: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"501"
		end

	frozen precondition_failed: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"412"
		end

	frozen not_acceptable: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"406"
		end

	frozen unauthorized: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"401"
		end

	frozen request_uri_too_long: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"414"
		end

	frozen not_found: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"404"
		end

	frozen unused: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"306"
		end

	frozen redirect_method: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"303"
		end

	frozen redirect_keep_verb: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"307"
		end

	frozen ok: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"200"
		end

	frozen reset_content: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"205"
		end

	frozen request_timeout: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"408"
		end

	frozen http_version_not_supported: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"505"
		end

	frozen found: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"302"
		end

	frozen created: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"201"
		end

	frozen bad_request: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"400"
		end

	frozen payment_required: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"402"
		end

	frozen ambiguous: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"300"
		end

	frozen internal_server_error: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"500"
		end

	frozen gone: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"410"
		end

	frozen proxy_authentication_required: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"407"
		end

	frozen unsupported_media_type: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"415"
		end

	frozen see_other: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"303"
		end

	frozen service_unavailable: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"503"
		end

	frozen not_modified: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"304"
		end

	frozen non_authoritative_information: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"203"
		end

	frozen method_not_allowed: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"405"
		end

	frozen bad_gateway: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"502"
		end

	frozen continue: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"100"
		end

	frozen moved: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"301"
		end

	frozen multiple_choices: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"300"
		end

	frozen use_proxy: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"305"
		end

	frozen switching_protocols: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"101"
		end

	frozen no_content: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"204"
		end

	frozen expectation_failed: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"417"
		end

	frozen partial_content: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"206"
		end

	frozen requested_range_not_satisfiable: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"416"
		end

	frozen request_entity_too_large: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"413"
		end

	frozen conflict: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"409"
		end

	frozen gateway_timeout: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"504"
		end

	frozen redirect: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"302"
		end

	frozen moved_permanently: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"301"
		end

	frozen temporary_redirect: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL enum signature :System.Net.HttpStatusCode use System.Net.HttpStatusCode"
		alias
			"307"
		end

end -- class SYSTEM_NET_HTTPSTATUSCODE
