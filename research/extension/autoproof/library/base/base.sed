s/6D7FF712-BBA5-4AC0-AABF-2D9880493A01/671C2BBD-94C8-4F69-A171-E00B512CA01D/
s/<option warning="error"/<option warning="warning"/
/dotnet_naming_convention/{
	a\	\	<capability>
	a\	\	\	<concurrency support="none"/>
	a\	\	\	<void_safety support="none"/>
	a\	\	</capability>
}
s/\( location="\)\([[:alnum:]]\)/\1\$ISE_LIBRARY\\library\\base\\\2/
/<cluster name="elks"/{
	i\	\	<cluster name="base2" location="base2\\" recursive="true"/>
	N
	s/\(<\/option>\)/\1/
	N
	T1
}
/<cluster name="ise"/{
	i\	\	<cluster name="eve" location="eve\\" recursive="true"/>
}
/<\/target>/{
	N
	s/\(\t<\/target>.*<target name="base_dotnet"\)/\	\	<cluster name="mml" location="mml\\" recursive="true"\/>\n\1/
}
/<option namespace="Base1">/{
	N
	s/\(<\/option>\)/\1/
	t1
}
b2
:1
	a\	\	\	<file_rule>
	a\	\	\	\	<description>Classes with additional or different code for AutoProof.</description>
	a\	\	\	\	<exclude>/any.e</exclude>
	a\	\	\	\	<exclude>/arguments.e</exclude>
	a\	\	\	\	<exclude>/arguments_32.e</exclude>
	a\	\	\	\	<exclude>/array.e</exclude>
	a\	\	\	\	<exclude>/fibonacci.e</exclude>
	a\	\	\	\	<exclude>/iterable.e</exclude>
	a\	\	\	\	<exclude>/iteration_cursor.e</exclude>
	a\	\	\	\	<exclude>/primes.e</exclude>
	a\	\	\	\	<exclude>/std_files.e</exclude>
	a\	\	\	</file_rule>
:2
