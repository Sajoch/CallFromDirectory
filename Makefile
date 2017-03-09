SERVICE=msys2
ICON_PATH=C:\msys2\msys2.ico
EXE_PATH=C:\msys2\msys2.exe
INSTALL_PATH=C:\msys2\callfromdirectory.exe

INSTALL_PATH_NEW:=$(subst \,\\\\,$(INSTALL_PATH))
EXE_PATH_NEW:=$(subst \,\\\\,$(EXE_PATH))
ICON_PATH_NEW:=$(subst \,\\\\,$(ICON_PATH))
ifneq (,$(ICON_PATH))
	ICON="\"ICON\"=\""$(ICON_PATH_NEW)"\""
endif

install.reg:
	@echo "Windows Registry Editor Version 5.00" > $@
	@echo >> $@
	@echo "[HKEY_CURRENT_USER\\Software\\Classes\\directory\\Background\\shell\\"$(SERVICE)"]" >> $@
	@echo "@=\""$(SERVICE)"\"" >> $@
	@echo $(ICON)"" >> $@
	@echo "[HKEY_CURRENT_USER\\Software\\Classes\\directory\\Background\\shell\\"$(SERVICE)"\\command]" >> $@
	@echo "@=\""$(INSTALL_PATH_NEW)" \\\""$(EXE_PATH_NEW)"\\\" \\\"%v\\\"\"" >> $@
	@echo >> $@

all: install.reg callfromdirectory.exe

callfromdirectory.exe: callfromdirectory.cpp
	cl $<

install: all
	cp callfromdirectory.exe $(INSTALL_PATH)
	Reg import install.reg

clean:
	rm callfromdirectory.exe
	rm callfromdirectory.obj
	rm install.reg
