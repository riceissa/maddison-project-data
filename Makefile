.PHONY: test
test:
	./proc_2013.py > out.sql
	mysql devecondata -e "drop table if exists maddison"
	mysql devecondata < schema.sql
	mysql devecondata < out.sql
