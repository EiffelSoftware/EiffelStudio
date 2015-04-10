note
	description: "Summary description for {INTRINSIC_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTRINSIC_INST

inherit
	CALL_INST
		rename
			make_external as make_external_call
		end

feature {NONE} -- Externals

	make_external (m: POINTER; id: NATURAL_32; tys: POINTER; num_tys: NATURAL_32): POINTER
		obsolete
			"Call make_external_fixed directly"
		local
			array: TYPE_ARRAY_REF
		do
			if tys = default_pointer then
				create array.make
			else
				create array.make_from_native_array (tys, num_tys)
			end
			Result := make_external_fixed (m, id, array.item)
		end

	make_external_fixed (module: POINTER; id: NATURAL_32; array: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/IntrinsicInst.h%""
		alias
			"[
				return llvm::Intrinsic::getDeclaration ((llvm::Module *) $module, (llvm::Intrinsic::ID) $id, *((llvm::ArrayRef <llvm::Type *> *) $array) )
			]"
		end

end
