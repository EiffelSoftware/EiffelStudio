-- I18N_BINARY_SEARCH_ARRAY_DICTIONAY check
-- with two_plural_forms_singular_one_zero
a:I18N_BINARY_SEARCH_ARRAY_DICTIONAY
create a.make (plural_tools.two_plural_forms_singular_one_zero)
data_generation(a,50,100)
data_query(a,50,100)
data_get(a,50,100