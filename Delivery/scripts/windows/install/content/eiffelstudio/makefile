HALLOW = %INIT_DIR%\install\bin\hallow.exe
HALLOW_FLAGS = -nologo -de:"\.svn$$" -x64 -c:"EiffelStudio"
HALLOW_FLAGS_X86 = $(HALLOW_FLAGS) -c:"x86"
HALLOW_FLAGS_X64 = $(HALLOW_FLAGS) -c:"x64"
MSBUILD = msbuild.exe
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
	borland.wxs \
	core.wxs \
	examples.wxs \
	libraries.wxs \
	enterprise_ec.wxs \
	gdiplus.wxs \
	gpl_ec.wxs


build: $(WXS)

borland.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\BCC55" -dr:"Dir.BCC55" -g:"Borland" -r -n:"Borland." > $@.tmp
	move $@.tmp $@

core.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\EiffelStudio" -dr:"INSTALLDIR" \
		-de:"\\EiffelStudio\\library$$" -de:"\\EiffelStudio\\examples$$" \
		-g:"Core" -r -n:"Core." > $@.tmp
	move $@.tmp $@

examples.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\EiffelStudio\examples" \
		-dr:"INSTALLDIR" -g:"Core.examples" -r -n:"Core.examples." > $@.tmp
	move $@.tmp $@

libraries.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\EiffelStudio\library" \
		-dr:"INSTALLDIR" -g:"Core.library" -r -n:"Core.library." > $@.tmp
	move $@.tmp $@


gdiplus.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\releases" \
		-dr:"Dir.Core.studio.spec.$$(var.IsePlatform).bin" -g:"gdiplus" -n:"gdiplus" \
		-fi:gdiplus.dll -de:"\*" > $@.tmp
	move $@.tmp $@

enterprise_ec.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\releases\enterprise_version" \
		-dr:"Dir.Core.studio.spec.$$(var.IsePlatform).bin" -g:"enterprise_ec" -n:"Core." > $@.tmp
	move $@.tmp $@

gpl_ec.wxs:
	$(HALLOW) $(HALLOW_FLAGS) "$(INSTALL_DIR)\releases\gpl_version" \
		-dr:"Dir.Core.studio.spec.$$(var.IsePlatform).bin" -g:"gpl_ec" -n:"Core." > $@.tmp
	move $@.tmp $@

###################################################################
#
# MSIs
#
###################################################################

enterprise_x86: $(WXS)
	$(MSBUILD) $(MSBUILD_FLAGS) /p:Configuration=studio_ent_x86 ..\..\package.sln

gpl_x86: $(WXS)
	$(MSBUILD) $(MSBUILD_FLAGS) /p:Configuration=studio_gpl_x86 ..\..\package.sln

enterprise_x64: $(WXS)
	$(MSBUILD) $(MSBUILD_FLAGS) /p:Configuration=studio_ent_x64 ..\..\package.sln

gpl_x64: $(WXS)
	$(MSBUILD) $(MSBUILD_FLAGS) /p:Configuration=studio_gpl_x64 ..\..\package.sln


###################################################################
#
# Clean builds
#
###################################################################

clean:
	for %i in ($(WXS)) do if exist %i del %i
	if exist *.msi del *.msi
