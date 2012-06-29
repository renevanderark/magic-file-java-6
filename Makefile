all: package

clean:
	rm libmagicjbind.so
	mvn clean

compile:
	g++ -shared -o libmagicjbind.so -I$(JAVA_HOME)/include/ -I$(JAVA_HOME)/include/linux/ -lmagic src/csource/nl_kb_magicfile_MagicFile.cc

test: compile
	mvn test;

package: compile
	mvn package

standalone: package
	mvn assembly:single

testrun: package
	mvn exec:java -Dexec.mainClass="nl.kb.magicfile.MagicFile" -Dexec.args="libmagicjbind.so"

install:
	cp libmagicjbind.so /usr/lib/
	ldconfig

uninstall:
	rm -f /usr/lib/libmagicjbind.so
