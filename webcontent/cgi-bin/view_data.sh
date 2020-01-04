#!/bin/bash
echo "Content-type: text/html"
echo ""

./header.sh

arr=()

SAVE_IFS=$IFS
IFS='=&'
set -- $QUERY_STRING
data_id=$(($2 + 0))
arr+=( $data_id )
IFS=$SAVE_IFS

i=0
while read c_link c_title c_icon; do
	if [ $i = ${arr[0]} ]; then
		arr+=( $c_title )
	fi
	((i+=1))
done <<< $(cat data/categories.dat)


data_count=7
if [ ! ${#4} = 0 ]; then
	data_count=$(( $4 + 0 ))
	arr+=( $data_count )
fi

data_order="desc"
if [ ! ${#6} = 0 ]; then
	if [ $6 = 1 ]; then
		data_order="asc"
	fi
	arr+=( $data_order )
fi

if [ ${#arr[1]} = 0 ]; then
	echo '<div class="alert alert-danger" role="alert">'
	echo "		<b>Error:</b> Kategorie nicht gefunden. <a href="index.sh" class="alert-link">Link nach Hauptseite</a>"
	echo "</div>"

	exit 1
fi

echo '
	<main class="wrapper container-fluid">
'
echo "		<h1>${arr[1]}daten Presentation</h1>"		
echo '		
		<section class="d_diagramm">
			<img width="100%" src="../img/plot_test.svg" alt="Plot test" />
		</section>

		<section class="d_table"> '
		
			./table.sh "${arr[@]}"
			
echo '	</section>
	</main>
'

./footer1.sh
