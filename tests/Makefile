###############################

#
# test programs Makefile
#

# Parent dir Makefile.conf has all necessary vars
include ../Makefile.conf

TINC    = -I.. -I../$(EC_ARCH)
LDFLAGS = -L../$(EC_ARCH)
MYLIBS    = -l$(MODULE)
MYF90FLAGS=$(INCPATH) $(DEFS) $(FCFLAGS)  $(MPEUFLAGS)

all: ctest ftest ctest2 ftest2

runtests: all
	./ctest
	@echo
	./ftest
	@echo
	./ctest2
	@echo
	./ftest2
	@echo

ctest: ctest.c
	$(CC) $(DEFS) $(TINC) $(ALLCFLAGS) -o $@ ctest.c $(LDFLAGS) $(MYLIBS)

ftest: ftest.F90
	$(FC) $(DEFS) $(TINC) $(MYF90FLAGS) -o $@ ftest.F90 $(LDFLAGS) $(MYLIBS)

ctest2: ctest_old.c
	$(CC) $(DEFS) $(TINC) $(ALLCFLAGS) -o $@ ctest_old.c $(LDFLAGS) $(MYLIBS)

ftest2: ftest_old.F90
	$(FC) $(DEFS) $(TINC) $(MYF90FLAGS) -o $@ ftest_old.F90 $(LDFLAGS) $(MYLIBS)

stest: stest.F90 stest2.o
	$(FC) $(DEFS) $(TINC) $(MYF90FLAGS) -o $@ stest.F90 stest2.o $(LDFLAGS) $(MYLIBS)


clean:
	rm -f ctest ftest ctest2 ftest2
	rm -f *.o
