
class LIMAN_R


feature

	l_ok: STRING is "L_OK";
				--everything fine

	l_soft: STRING is "L_SOFT";
				-- software is unknown for this licence

	l_clmax: STRING is "L_CLMAX";
				-- too many clients

	l_mem: STRING is "L_MEM";
				-- Out of memory

	l_nick: STRING is "L_NICK";
				-- Invalid nickname

	l_client: STRING is "L_CLIENT";
				-- No such client

	l_addr: STRING is "L_ADDR";
				-- Address changed

	l_lic: STRING is "L_LIC";
				-- licence not found

	l_auth: STRING is "L_AUTH";
				-- software lacks authorisation

	l_active: STRING is "L_ACTIVE";
				-- feature is disabled

	l_host: STRING is "L_HOST";
				-- host is not authorised

	l_start: STRING is "L_START";
				-- starting date not reached

	l_end: STRING is "L_END";
				-- fetaure has expired

	l_socket: STRING is "L_SOCKET";
				-- cannot create socket

	l_nohost: STRING is "L_NOHOST";
				-- host is unknown

	l_down: STRING is "L_DOWN";
				-- deamon does not answer

	l_denied: STRING is "L_DENIED";
				-- access denied

	l_wrong: STRING is "L_WRONG";
				-- talking to wrong deamon

	l_proto: STRING is "L_PROTO";
				-- protocol error

	l_nolic: STRING is "L_NOLIC";
				-- licence not registered

	l_error: STRING is "L_ERROR";
				-- general error condition

	l_lost: STRING is "L_LOST";
				-- licence lost

	l_nokey: STRING is "L_NOKEY";
				-- cannot find key file

	l_badkey: STRING is "L_BAD_KEY";
				-- incorrect key file

	l_licdir: STRING is "L_LICDIR";
				-- licence directory not found

	l_version: STRING is "L_VERSION";
				-- wrong version number;

	l_badhost: STRING is "L_BADHOST";
				-- host not habitated for licencing

	
	
end
