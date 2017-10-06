.PHONY: test
test:
	./proc_csv.py > out.sql
	mysql devecondata -e "drop table if exists maddison"
	mysql devecondata < schema.sql
	mysql devecondata < out.sql
