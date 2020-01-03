#!/bin/bash
echo "Content-type: text/html"
echo ""

./header.sh

IFS='=&'
set -- $QUERY_STRING
cat_id=$2

cat "data/categories.sh" | while read link title rest; do
	echo "$title <br/>"
done

echo '
	<main class="wrapper container-fluid">
		<h1>Data Presentation</h1>
		
		<section class="d_diagramm">
			<img width="100%" src="../img/plot_test.svg" alt="Plot test" />
		</section>

		<section class="d_table"> '
		
			./table.sh "Temperatur" $cat_id
			
echo '	</section>
	</main>
'

./footer1.sh
