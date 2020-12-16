HALLOW = %INIT_DIR%\install\bin\hallow.exe
HALLOW_FLAGS = -nologo -de:"\.svn$$" -x64 -c:"EiffelStudio"
HALLOW_FLAGS_X86 = $(HALLOW_FLAGS) -c:"x86"
HALLOW_FLAGS_X64 = $(HALLOW_FLAGS) -c:"x64"
MSBUILD = C:\Windows\Microsoft.NET\Framework\v2.0.50727\msbuild.exe
MSBUILD_FLAGS = /nologo /verbosity:quiet 

###################################################################
#
# Package targets
#
###################################################################

all:: build

###################################################################
#
# Build targets
#
###################################################################

WXS = \
	studio_gcc.wxs \
	studio_core.wxs \
	studio_examples.wxs \
	studio_libraries.wxs \
	studio_contrib.wxs \
	studio_unstable.wxs \
	studio_tools.wxs \
	studio_gobo.wxs \
	studio_gdiplus.wxs \
	studio_ent_ec.wxs \
	studio_std_ec.wxs

WXS_STD = \
	studio_gcc.wxs \
	studio_core.wxs \
	studio_examples.wxs \
	studio_libraries.wxs \
	studio_contrib.wxs \
	studio_unstable.wxs \
	studio_tools.wxs \
	studio_gobo.wxs \
	studio_gdiplus.wxs \
	studio_std_ec.wxs

WXS_ENT = \
	studio_gcc.wxs \
	studio_core.wxs \
	studio_examples.wxs \
	studio_libraries.wxs \
	studio_contrib.wxs \
	studio_unstable.wxs \
	studio_tools.wxs \
	studio_gobo.wxs \
	studio_gdiplus.wxs \
	studio_ent_ec.wxs


build: $(WXS)

studio_gcc.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\EiffelStudio\gcc" -dr:"Dir.gcc" -g:"gcc" -r -n:"gcc." > $@.tmp
	move $@.tmp $@

studio_core.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\EiffelStudio" -dr:"INSTALLDIR" \
		-de:"\\EiffelStudio\\library$$" \
		-de:"\\EiffelStudio\\contrib$$" \
		-de:"\\EiffelStudio\\unstable$$" \
		-de:"\\EiffelStudio\\tools$$" \
		-de:"\\EiffelStudio\\examples$$" \
		-de:"\\EiffelStudio\\gcc$$" \
		-fe:"\\EiffelStudio\\studio\\spec\\w.*\\estudio.exe$$" \
		-fe:"\\EiffelStudio\\esbuilder\\spec\\w.*\\esbuilder.exe$$" \
		-g:"Core" -r -n:"Core." > $@.tmp
	move $@.tmp $@

studio_examples.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\EiffelStudio\examples" \
		-dr:"Dir.Core.examples" -g:"Core.examples" -r -n:"Core.examples." > $@.tmp
	move $@.tmp $@

studio_libraries.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\EiffelStudio\library" \
		-dr:"Dir.Core.library" \
		-de:"\\EiffelStudio\\library\\gobo$$" \
		-g:"Core.library" -r -n:"Core.library." > $@.tmp
	move $@.tmp $@

studio_contrib.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\EiffelStudio\contrib" \
		-dr:"Dir.Core.contrib" \
		-g:"Core.contrib" -r -n:"Core.contrib." > $@.tmp
	move $@.tmp $@

studio_unstable.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\EiffelStudio\unstable" \
		-dr:"Dir.Core.unstable" \
		-g:"Core.unstable" -r -n:"Core.unstable." > $@.tmp
	move $@.tmp $@

studio_tools.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\EiffelStudio\tools" \
		-dr:"Dir.Core.tools" \
		-g:"Core.tools" -r -n:"Core.tools." > $@.tmp
	move $@.tmp $@

studio_gobo.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\EiffelStudio\library\gobo" \
		-dr:"Dir.Core.library.gobo" -g:"Core.library.gobo" -r -n:"Core.library.gobo." > $@.tmp
	move $@.tmp $@

studio_gdiplus.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\releases" \
		-dr:"Dir.Core.studio.spec.$$(var.IsePlatform).bin" -g:"gdiplus" -n:"gdiplus" \
		-fi:gdiplus.dll -de:"\*" > $@.tmp
	move $@.tmp $@

studio_ent_ec.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\releases\enterprise_version" \
		-dr:"Dir.Core.studio.spec.$$(var.IsePlatform).bin" -g:"enterprise_ec" -n:"Core." > $@.tmp
	move $@.tmp $@

studio_std_ec.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\releases\standard_version" \
		-dr:"Dir.Core.studio.spec.$$(var.IsePlatform).bin" -g:"standard_ec" -n:"Core." > $@.tmp
	move $@.tmp $@

###################################################################
#
# MSIs
#
###################################################################

enterprise_x86: $(WXS_ENT)
	$(MSBUILD) $(MSBUILD_FLAGS) /p:Configuration=studio_ent_x86 /p:Platform=x86 ..\..\package.sln

standard_x86: $(WXS_STD)
	$(MSBUILD) $(MSBUILD_FLAGS) /p:Configuration=studio_std_x86 /p:Platform=x86 ..\..\package.sln

enterprise_x64: $(WXS_ENT)
	$(MSBUILD) $(MSBUILD_FLAGS) /p:Configuration=studio_ent_x64 /p:Platform=x64 ..\..\package.sln

standard_x64: $(WXS_STD)
	$(MSBUILD) $(MSBUILD_FLAGS) /p:Configuration=studio_std_x64 /p:Platform=x64 ..\..\package.sln


###################################################################
#
# Clean builds
#
###################################################################

clean:
	for %i in ($(WXS_STD)) do if exist %i del %i
	for %i in ($(WXS_ENT)) do if exist %i del %i
	if exist *.msi del *.msi
