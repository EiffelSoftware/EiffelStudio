# Preferences library.
: Copyright (c) 1984-2019, Eiffel Software and others.
: Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt).

On Windows to either choose xml or registry storage, you need to use `PREFERENCES_STORAGE_REGISTRY` or `PREFERENCES_STORAGE_XML` when initializing the preferences. Otherwise it uses the default, i.e:
- On Windows: default is using registry key storage
- On non Windows: default is using XML storage

It is possible to override the default storage by using the custom variable `pref_default_storage` in your application ECF file, for instance to force xml on Windows:
```
					<custom name="pref_default_storage" value="xml"/>
```


