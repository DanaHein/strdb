clean:
	rm -rf _tests
run_test:
	mkdir _tests
	Rscript R/dev/test_download_enrichments.R
