#include "net.h"
#include "curextern.h"

#define DEBUG

void print_server_list() {
    SERVER *tmp;

    for(tmp=_concur_ser_list; tmp != NULL; tmp=tmp->next)
#ifdef DEBUG
        printf("<host=[%d], port=%d, sock=%d, count=%d>\n", (tmp->hostaddr), tmp->pid, tmp->sock, tmp->count);
#else
        printf("<host=[%s], port=%d, sock=%d, count=%d>\n", c_get_name_from_addr(tmp->hostaddr), tmp->pid, tmp->sock, tmp->count);
#endif

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
#ifdef DEBUG
		printf("<(%d, %d), sock=%d, count=%d, res#=%d, RC=%d, buffed_cmd=%s>\n", (tmp_cli->hostaddr), tmp_cli->pid, tmp_cli->sock, tmp_cli->count, tmp_cli->reservation, tmp_cli->type==constant_remote_client, (tmp_cli->req_buf).command!=constant_not_defined?command_text((tmp_cli->req_buf).command):"NULL");
#else
		printf("<(%s, %d), sock=%d, count=%d, res#=%d, RC=%d, buffed_cmd=%s>\n", c_get_name_from_addr(tmp_cli->hostaddr), tmp_cli->pid, tmp_cli->sock, tmp_cli->count, tmp_cli->reservation, tmp_cli->type==constant_remote_client, (tmp_cli->req_buf).command!=constant_not_defined?command_text((tmp_cli->req_buf).command):"NULL");
#endif
	}
	if (_concur_current_client) {
		tmp_cli = (_concur_current_client);
#ifdef DEBUG
		printf("<(%d, %d), sock=%d, count=%d, res#=%d, RC=%d, buffed_cmd=%s>\n", (tmp_cli->hostaddr), tmp_cli->pid, tmp_cli->sock, tmp_cli->count, tmp_cli->reservation, tmp_cli->type==constant_remote_client, (tmp_cli->req_buf).command!=constant_not_defined?command_text((tmp_cli->req_buf).command):"NULL");
#else
		printf("<(%s, %d), sock=%d, count=%d, res#=%d, RC=%d, buffed_cmd=%s>\n", c_get_name_from_addr(tmp_cli->hostaddr), tmp_cli->pid, tmp_cli->sock, tmp_cli->count, tmp_cli->reservation, tmp_cli->type==constant_remote_client, (tmp_cli->req_buf).command!=constant_not_defined?command_text((tmp_cli->req_buf).command):"NULL");
#endif
	}	

	printf("\n---------------  P a r e n t  ---------------\n");
	if (_concur_parent) 
		printf("<name=%s, pid=%d, sock=%d, count=%d>\n", c_get_name_from_addr(_concur_parent->hostaddr), _concur_parent->pid, _concur_parent->sock, _concur_parent->count);

	printf("\n---------------  Child  List  ---------------\n");
	for(tmp_child=_concur_child_list; tmp_child; tmp_child=tmp_child->next) {
#ifdef DEBUG
		printf("<name=%d, pid=%d, sock=%d, count=%d>\n", (tmp_child->hostaddr), tmp_child->pid, tmp_child->sock, tmp_child->count);
#else
		printf("<name=%s, pid=%d, sock=%d, count=%d>\n", c_get_name_from_addr(tmp_child->hostaddr), tmp_child->pid, tmp_child->sock, tmp_child->count);
#endif
	}

	printf("\n---------------  Server List  ---------------\n");
	print_server_list();

	printf("\n------------- Imported Object List ----------\n");
	for(tmp_imp_tab=_concur_imported_obj_tab; tmp_imp_tab; tmp_imp_tab=tmp_imp_tab->next) {
#ifdef DEBUG
		printf("Objects imported from <%d, %d>: \n", (tmp_imp_tab->hostaddr), tmp_imp_tab->pid);
#else
		printf("Objects imported from <%s, %d>: \n", c_get_name_from_addr(tmp_imp_tab->hostaddr), tmp_imp_tab->pid);
#endif
		for(tmp_imp_list=tmp_imp_tab->list_root; tmp_imp_list; tmp_imp_list=tmp_imp_list->next) {
			printf("\t<OID=%d, proxy_id=%d>\n", tmp_imp_list->oid, tmp_imp_list->proxy_id);
		}
	}

	printf("\n-------------  Reference Table --------------\n");
	for(tmp_tab=_concur_ref_table; tmp_tab; tmp_tab=tmp_tab->next) {
#ifdef DEBUG
		printf("Objects exported to <%d, %d>: \n", (tmp_tab->hostaddr), tmp_tab->pid);
#else
		printf("Objects exported to <%s, %d>: \n", c_get_name_from_addr(tmp_tab->hostaddr), tmp_tab->pid);
#endif
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
