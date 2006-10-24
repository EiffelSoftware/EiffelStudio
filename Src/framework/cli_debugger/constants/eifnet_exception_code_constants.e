indexing
	description: "Constants used to identify Dotnet Exception"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_EXCEPTION_CODE_CONSTANTS

feature {NONE} -- Exception code

	except_exception: INTEGER is 0x02000012            --| 33554450 |--
	--except_ambiguousmatchexception: INTEGER is 0x020000DD            --| 1711157331 |--
	except_ambiguousmatchexception: INTEGER is 0x0200012D              --| 33554733 |--
	except_appdomainunloadedexception: INTEGER is 0x02000037           --| 33554487 |--
	except_applicationexception: INTEGER is 0x02000025                 --| 33554469 |--
	except_argumentexception: INTEGER is 0x02000038            --| 33554488 |--
	except_argumentnullexception: INTEGER is 0x02000039                --| 33554489 |--
	except_argumentoutofrangeexception: INTEGER is 0x0200003A          --| 33554490 |--
	except_arithmeticexception: INTEGER is 0x0200003C          --| 33554492 |--
	except_arraytypemismatchexception: INTEGER is 0x0200003D 	--| 33554493 |--
	except_badimageformatexception: INTEGER is 0x02000041              --| 33554497 |--
	except_cannotunloadappdomainexception: INTEGER is 0x02000046               --| 33554502 |--
	except_comexception: INTEGER is 0x020002B4                 --| 33555124 |--
	except_contextmarshalexception: INTEGER is 0x02000055              --| 33554517 |--
	except_cryptographicexception: INTEGER is 0x02000216               --| 33554966 |--
	except_cryptographicunexpectedoperationexception: INTEGER is 0x02000217  --| 33554967 |--
	except_customattributeformatexception: INTEGER is 0x02000144               --| 33554756 |--
	except_directorynotfoundexception: INTEGER is 0x0200031C           --| 33555228 |--
	except_dividebyzeroexception: INTEGER is 0x02000065                --| 33554533 |--
	except_dllnotfoundexception: INTEGER is 0x0200006B                 --| 33554539 |--
	except_duplicatewaitobjectexception: INTEGER is 0x02000067                 --| 33554535 |--
	except_endofstreamexception: INTEGER is 0x0200031D                 --| 33555229 |--
	except_entrypointnotfoundexception: INTEGER is 0x0200006A          --| 33554538 |--
	except_executionengineexception: INTEGER is 0x02000019             --| 33554457 |--
	except_externalexception: INTEGER is 0x020002B3            --| 33555123 |--
	except_fieldaccessexception: INTEGER is 0x02000070                 --| 33554544 |--
	except_fileloadexception: INTEGER is 0x02000322            --| 33555234 |--
	except_filenotfoundexception: INTEGER is 0x02000323                --| 33555235 |--
	except_formatexception: INTEGER is 0x02000072              --| 33554546 |--
	except_indexoutofrangeexception: INTEGER is 0x02000079             --| 33554553 |--
	except_invalidcastexception: INTEGER is 0x0200007E                 --| 33554558 |--
	except_invalidcomobjectexception: INTEGER is 0x020002C0            --| 33555136 |--
	except_invalidfiltercriteriaexception: INTEGER is 0x02000151               --| 33554769 |--
	except_invalidolevarianttypeexception: INTEGER is 0x020002C1               --| 33555137 |--
	except_invalidoperationexception: INTEGER is 0x0200007F            --| 33554559 |--
	except_invalidprogramexception: INTEGER is 0x02000080              --| 33554560 |--
	except_ioexception: INTEGER is 0x0200031B          --| 33555227 |--
	except_isolatedstorageexception: INTEGER is 0x020004CC 			--| 33555660 |--
	except_marshaldirectiveexception: INTEGER is 0x020002CF            --| 33555151 |--
	except_memberaccessexception: INTEGER is 0x02000023                --| 33554467 |--
	except_methodaccessexception: INTEGER is 0x02000087                --| 33554567 |--
	except_missingfieldexception: INTEGER is 0x02000089              --| 33554569  |--
	except_missingmanifestresourceexception: INTEGER is 0x020001DE  	--| 33554910  |--
	except_missingmemberexception: INTEGER is 0x02000088 		--| 33554568 |--
	except_missingmethodexception: INTEGER is 0x0200008A 		--| 33554570 |--
	except_multicastnotsupportedexception: INTEGER is 0x0200008B               --| 33554571 |--
	except_notfinitenumberexception: INTEGER is 0x0200008D             --| 33554573 |--
	except_notimplementedexception: INTEGER is 0x0200008E              --| 33554574 |--
	except_notsupportedexception: INTEGER is 0x0200008F                --| 33554575 |--
	except_nullreferenceexception: INTEGER is 0x02000090               --| 33554576 |--
	except_objectdisposedexception: INTEGER is 0x02000092 		--| 33554578 |--
	except_outofmemoryexception: INTEGER is 0x02000017                 --| 33554455 |--
	except_overflowexception: INTEGER is 0x02000096            --| 33554582 |--
	except_pathtoolongexception: INTEGER is 0x0200032B                 --| 33555243 |--
	except_platformnotsupportedexception: INTEGER is 0x0200009A                --| 33554586 |--
	except_policyexception: INTEGER is 0x0200026B              --| 33555051 |--
	except_rankexception: INTEGER is 0x0200009C                --| 33554588 |--
	except_reflectiontypeloadexception: INTEGER is 0x02000163          --| 33554787 |--
	except_remotingexception: INTEGER is 0x02000480            --| 33555584 |--
	except_remotingtimeoutexception: INTEGER is 0x02000482             --| 33555586 |--
	except_safearrayrankmismatchexception: INTEGER is 0x020002D4 		--| 33555156 |--
	except_safearraytypemismatchexception: INTEGER is 0x020002D5 		--| 33555157 |--
	except_securityexception: INTEGER is 0x020003AB            --| 33555371 |--
	except_sehexception: INTEGER is 0x020002D6                 --| 33555158 |--
	except_serializationexception: INTEGER is 0x02000189               --| 33554825 |--
	except_serverexception: INTEGER is 0x02000481              --| 33555585 |--
	except_stackoverflowexception: INTEGER is 0x02000018               --| 33554456 |--
	except_synchronizationlockexception: INTEGER is 0x020000CC                 --| 33554636 |--
	except_systemexception: INTEGER is 0x02000016              --| 33554454 |--
	except_targetexception: INTEGER is 0x0200016C              --| 33554796 |--
	except_targetinvocationexception: INTEGER is 0x0200016D            --| 33554797 |--
	except_targetparametercountexception: INTEGER is 0x0200016E                --| 33554798 |--
	except_threadabortexception: INTEGER is 0x020000CF                 --| 33554639 |--
	except_threadinterruptedexception: INTEGER is 0x020000D2           --| 33554642 |--
	except_threadstateexception: INTEGER is 0x020000DB                 --| 33554651 |--
	except_threadstopexception: INTEGER is 0x020000DD          --| 33554653 |--
	except_typeinitializationexception: INTEGER is 0x020000B0          --| 33554608 |--
	except_typeloadexception: INTEGER is 0x02000069            --| 33554537 |--
	except_typeunloadedexception: INTEGER is 0x02000052                --| 33554514 |--
	except_unauthorizedaccessexception: INTEGER is 0x020000B5          --| 33554613 |--
	except_verificationexception: INTEGER is 0x020003B0                --| 33555376 |--
	except_xmlsyntaxexception: INTEGER is 0x02000363           --| 33555299 |--

feature

	exception_string_representation (a_code: INTEGER): STRING is
		do
			inspect a_code
			when except_ambiguousmatchexception then
				Result := "[0x0200012D] AmbiguousMatchException" 
			when except_appdomainunloadedexception then
				Result := "[0x02000037] AppDomainunLoadedException" 
			when except_applicationexception then
				Result := "[0x02000025] ApplicationException" 
			when except_argumentexception then
				Result := "[0x02000038] ArgumentException" 
			when except_argumentnullexception then
				Result := "[0x02000039] ArgumentNullException" 
			when except_argumentoutofrangeexception then
				Result := "[0x0200003A] ArgumentOutOfRangeException" 
			when except_arithmeticexception then
				Result := "[0x0200003C] ArithmeticException" 
			when except_arraytypemismatchexception then
				Result := "[0x0200003D] ArrayTypeMismatchException" 
			when except_badimageformatexception then
				Result := "[0x02000041] BadImageFormatException" 
			when except_cannotunloadappdomainexception then
				Result := "[0x02000046] CannotUnloadAppDomainException" 
			when except_comexception then
				Result := "[0x020002B4] ComException" 
			when except_contextmarshalexception then
				Result := "[0x02000055] ContextMarshalException" 
			when except_cryptographicexception then
				Result := "[0x02000216] CryptographicException" 
			when except_cryptographicunexpectedoperationexception then
				Result := "[0x02000217] CryptographicUnexpectedOperationException" 
			when except_customattributeformatexception then
				Result := "[0x02000144] CustomAttributeFormatException" 
			when except_directorynotfoundexception then
				Result := "[0x0200031C] DirectoryNotFoundException" 
			when except_dividebyzeroexception then
				Result := "[0x02000065] DivideByZeroException" 
			when except_dllnotfoundexception then
				Result := "[0x0200006B] DllNotFoundException" 
			when except_duplicatewaitobjectexception then
				Result := "[0x02000067] DuplicateWaitObjectException" 
			when except_endofstreamexception then
				Result := "[0x0200031D] EndOfStreamException" 
			when except_entrypointnotfoundexception then
				Result := "[0x0200006A] EntryPointNotFoundException" 
			when except_exception then
				Result := "[0x02000012] Exception" 
			when except_executionengineexception then
				Result := "[0x02000019] ExecutionEngineException" 
			when except_externalexception then
				Result := "[0x020002B3] ExternalException" 
			when except_fieldaccessexception then
				Result := "[0x02000070] FieldAccessException" 
			when except_fileloadexception then
				Result := "[0x02000322] FileLoadException" 
			when except_filenotfoundexception then
				Result := "[0x02000323] FileNotFoundException" 
			when except_formatexception then
				Result := "[0x02000072] FormatException" 
			when except_indexoutofrangeexception then
				Result := "[0x02000079] IndexOutOfRangeException" 
			when except_invalidcastexception then
				Result := "[0x0200007E] InvalidCastException" 
			when except_invalidcomobjectexception then
				Result := "[0x020002C0] InvalidComObjectException" 
			when except_invalidfiltercriteriaexception then
				Result := "[0x02000151] InvalidFilterCriteriaException" 
			when except_invalidolevarianttypeexception then
				Result := "[0x020002C1] InvalidOleVariantTypeException" 
			when except_invalidoperationexception then
				Result := "[0x0200007F] InvalidOperationException" 
			when except_invalidprogramexception then
				Result := "[0x02000080] InvalidProgramException" 
			when except_ioexception then
				Result := "[0x0200031B] IOException" 
			when except_isolatedstorageexception then
				Result := "[0x020004CC] IsolatedStorageException" 
			when except_marshaldirectiveexception then
				Result := "[0x020002CF] MarshalDirectiveException" 
			when except_memberaccessexception then
				Result := "[0x02000023] MemberAccessException" 
			when except_methodaccessexception then
				Result := "[0x02000087] MethodAccessException" 
			when except_missingfieldexception then
				Result := "[0x02000089] MissingFieldException" 
			when except_missingmanifestresourceexception then
				Result := "[0x020001DE] MissingManifestResourceException" 
			when except_missingmemberexception then
				Result := "[0x02000088] MissingMemberException" 
			when except_missingmethodexception then
				Result := "[0x0200008A] MissingMethodException" 
			when except_multicastnotsupportedexception then
				Result := "[0x0200008B] MultiCastNotSupportedException" 
			when except_notfinitenumberexception then
				Result := "[0x0200008D] NotFiniteNumberException" 
			when except_notimplementedexception then
				Result := "[0x0200008E] NotImplementedException" 
			when except_notsupportedexception then
				Result := "[0x0200008F] NotSupportedException" 
			when except_nullreferenceexception then
				Result := "[0x02000090] NullReferenceException" 
			when except_objectdisposedexception then
				Result := "[0x02000092] ObjectDisposedException" 
			when except_outofmemoryexception then
				Result := "[0x02000017] OutOfMemoryException" 
			when except_overflowexception then
				Result := "[0x02000096] OverflowException" 
			when except_pathtoolongexception then
				Result := "[0x0200032B] PathTooLongException" 
			when except_platformnotsupportedexception then
				Result := "[0x0200009A] PlatFormnotSupportedException" 
			when except_policyexception then
				Result := "[0x0200026B] PolicyException" 
			when except_rankexception then
				Result := "[0x0200009C] RankException" 
			when except_reflectiontypeloadexception then
				Result := "[0x02000163] ReflectionTypeLoadException" 
			when except_remotingexception then
				Result := "[0x02000480] RemotingException" 
			when except_remotingtimeoutexception then
				Result := "[0x02000482] RemotingTimeoutException" 
			when except_safearrayrankmismatchexception then
				Result := "[0x020002D4] SafeArrayRankMismatchException" 
			when except_safearraytypemismatchexception then
				Result := "[0x020002D5] SafeArrayTypeMismatchException" 
			when except_securityexception then
				Result := "[0x020003AB] SecurityException" 
			when except_sehexception then
				Result := "[0x020002D6] SehException" 
			when except_serializationexception then
				Result := "[0x02000189] SerializationException" 
			when except_serverexception then
				Result := "[0x02000481] ServerException" 
			when except_stackoverflowexception then
				Result := "[0x02000018] StackOverflowException" 
			when except_synchronizationlockexception then
				Result := "[0x020000CC] SynchronizationLockException" 
			when except_systemexception then
				Result := "[0x02000016] SystemException" 
			when except_targetexception then
				Result := "[0x0200016C] TargetException" 
			when except_targetinvocationexception then
				Result := "[0x0200016D] TargetInvocationException" 
			when except_targetparametercountexception then
				Result := "[0x0200016E] TargetParameterCountException" 
			when except_threadabortexception then
				Result := "[0x020000CF] ThreadAbortException" 
			when except_threadinterruptedexception then
				Result := "[0x020000D2] ThreadInterruptedException" 
			when except_threadstateexception then
				Result := "[0x020000DB] ThreadStateException" 
			when except_threadstopexception then
				Result := "[0x020000DD] ThreadStopException" 
			when except_typeinitializationexception then
				Result := "[0x020000B0] TypeInitializationException" 
			when except_typeloadexception then
				Result := "[0x02000069] TypeLoadException" 
			when except_typeunloadedexception then
				Result := "[0x02000052] TypeUnloadedException" 
			when except_unauthorizedaccessexception then
				Result := "[0x020000B5] UnauthorizedAccessException" 
			when except_verificationexception then
				Result := "[0x020003B0] VerificationException" 
			when except_xmlsyntaxexception then
				Result := "[0x02000363] XmlSyntaxException" 
			else
				Result := "Unknown Exception"
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
