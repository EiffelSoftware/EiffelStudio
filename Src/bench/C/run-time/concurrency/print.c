#include "net.h"
#include "curextern.h"

void print_server_list() {
    SERVER *tmp;

    for(tmp=_concur_ser_list; tmp != NULL; tmp=tmp->next)
        printf("<host=[%s], port=%d, sock=%d, count=%d>\n", tmp->hostname, tmp->pid, tmp->sock, tmp->count);

    return;
}

void print_ref_table_and_exported_object() {
	
	REF_TABLE_NODE *tmp_tab;
	REF_LIST_NODE *tmp_list;
	EXPORTED_OBJ_LIST_NODE *tmp_exp;
	CLIENT *tmp_cli;
	CHILD *tmp_child;

	IMPORTED_OBJ_TABLE_NODE *tmp_imp_tab;
	PROXY_LIST_NODE *tmp_imp_list;

	printf("\n************************ %d *******************************\n",
_concur_pid);
	printf("---------------  Client List  ---------------\n");
	for(tmp_cli=_concur_cli_list; tmp_cli; tmp_cli=tmp_cli->next) {
		printf("<(%s, %d), sock=%d, count=%d, res#=%d, RC=%d, buffed_cmd=%s>\n", tmp_cli->hostname, tmp_cli->pid, tmp_cli->sock, tmp_cli->count, tmp_cli->reservation, tmp_cli->type==constant_remote_client, (tmp_cli->req_buf).command!=constant_not_defined?command_text((tmp_cli->req_buf).command):"NULL");
	}
	if (_concur_current_client) {
		tmp_cli = (_concur_current_client);
		printf("<(%s, %d), sock=%d, count=%d, res#=%d, RC=%d, buffed_cmd=%s>\n", tmp_cli->hostname, tmp_cli->pid, tmp_cli->sock, tmp_cli->count, tmp_cli->reservation, tmp_cli->type==constant_remote_client, (tmp_cli->req_buf).command!=constant_not_defined?command_text((tmp_cli->req_buf).command):"NULL");
	}	

	printf("\n---------------  P a r e n t  ---------------\n");
	if (_concur_parent) 
		printf("<name=%s, pid=%d, sock=%d, count=%d>\n", _concur_parent->hostname, _concur_parent->pid, _concur_parent->sock, _concur_parent->count);

	printf("\n---------------  Child  List  ---------------\n");
	for(tmp_child=_concur_child_list; tmp_child; tmp_child=tmp_child->next) {
		printf("<name=%s, pid=%d, sock=%d, count=%d>\n", tmp_child->hostname, tmp_child->pid, tmp_child->sock, tmp_child->count);
	}

	printf("\n---------------  Server List  ---------------\n");
	print_server_list();

	printf("\n------------- Imported Object List ----------\n");
	for(tmp_imp_tab=_concur_imported_obj_tab; tmp_imp_tab; tmp_imp_tab=tmp_imp_tab->next) {
		printf("Objects imported from <%s, %d>: \n", tmp_imp_tab->hostname, tmp_imp_tab->pid);
		for(tmp_imp_list=tmp_imp_tab->list_root; tmp_imp_list; tmp_imp_list=tmp_imp_list->next) {
			printf("\t<OID=%d, proxy_id=%d>\n", tmp_imp_list->oid, tmp_imp_list->proxy_id);
		}
	}

	printf("\n-------------  Reference Table --------------\n");
	for(tmp_tab=_concur_ref_table; tmp_tab; tmp_tab=tmp_tab->next) {
		printf("Objects exported to <%s, %d>: \n", tmp_tab->hostname, tmp_tab->pid);
		for(tmp_list=tmp_tab->ref_list; tmp_list; tmp_list=tmp_list->next) {
			printf("\t<OID=%d, count=%d>\n", tmp_list->oid, tmp_list->count);
		}
	}

	printf("\n-------------  Exported Objects -------------\n");
	for(tmp_exp=_concur_exported_obj_list; tmp_exp; tmp_exp=tmp_exp->next) {
		printf("<OID = %d, count = %d, pending=%d>\n", tmp_exp->oid, tmp_exp->count, tmp_exp->pending);
	}
	
	printf("*************************************************************\n");
}
