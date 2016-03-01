
# Leave this block near the top to make clear the reference to site where
# generation of automatic dependencies is explained.
# http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/
DEPDIR := .d
$(shell mkdir -p $(DEPDIR) >/dev/null)
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.Td
COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
COMPILE.cc = $(CXX) $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
POSTCOMPILE = mv -f $(DEPDIR)/$*.Td $(DEPDIR)/$*.d
%.o : %.c
%.o : %.c $(DEPDIR)/%.d
        $(COMPILE.c) $(OUTPUT_OPTION) $<
        $(POSTCOMPILE)
%.o : %.cpp
%.o : %.cpp $(DEPDIR)/%.d
        $(COMPILE.cc) $(OUTPUT_OPTION) $<
        $(POSTCOMPILE)
$(DEPDIR)/%.d: ;
.PRECIOUS: $(DEPDIR)/%.d

#
# Put custom stuff (including default rule) here.
#

# This must be the last line.
# http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/
-include $(patsubst %,$(DEPDIR)/%.d,$(basename $(SRCS)))
