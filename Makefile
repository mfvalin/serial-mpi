SHELL		= /bin/sh
###############################
include Makefile.conf

VPATH=$(SRCDIR)/mpi-serial
# SOURCE FILES

MODULE		= mpi-serial

SRCS_F90	= fort.F90 \
                  mpif.F90

SRCS_C		= mpi.c \
		  send.c \
		  recv.c \
		  collective.c \
		  req.c \
		  list.c \
		  handles.c \
                  comm.c \
                  group.c \
                  time.c \
                  pack.c \
                  type.c \
                  type_const.c \
                  copy.c \
                  op.c \
                  cart.c \
                  getcount.c \
                  probe.c \
                  info.c


OBJS_ALL	= $(SRCS_C:.c=.o) \
		  $(SRCS_F90:.F90=.o)


INCPATH:= -I.


###############################

# TARGETS

LIB	= $(EC_ARCH)/lib$(MODULE).a

default: lib 

fort.o: mpif.h

lib: $(OBJS_ALL)
	echo $(OBJS_ALL)
	mkdir -p $(EC_ARCH)
	$(RM) $(LIB)
	$(AR) $(LIB) $(OBJS_ALL)
	mv mpi.mod $(EC_ARCH)/.
	rm -f *.o


###############################
#RULES

.SUFFIXES:
.SUFFIXES: .F90 .c .o 

.c.o:
	$(CC) -c $(INCPATH) $(DEFS) $(CPPDEFS) $(CFLAGS) $<

.F90.o:
	$(FC) -c $(INCFLAG). $(INCPATH) $(DEFS) $(FPPDEFS) $(FCFLAGS) $(MPEUFLAGS) $<

MYF90FLAGS=$(INCPATH) $(DEFS) $(FCFLAGS)  $(MPEUFLAGS)

.PHONY: clean tests install

clean:
	/bin/rm -f *.o mpi.mod 
	cd tests ; $(MAKE) clean

tests:
	cd tests; make

install: $(LIB)
	mkdir -p DIST/include/$(EC_ARCH)
	cp mpif.h mpi.h DIST/include
	cp $(EC_ARCH)/*.mod DIST/include/$(EC_ARCH)/.
	mkdir -p DIST/lib/$(EC_ARCH)
	cp $(EC_ARCH)/lib*.a DIST/lib/$(EC_ARCH)/.


