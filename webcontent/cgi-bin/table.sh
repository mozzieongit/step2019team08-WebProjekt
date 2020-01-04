data=()

for dat in "$@"; do
  data+=( $dat )
done

cat_id="${data[0]}"
cat_title="${data[1]}"
data_range="${data[2]}"
data_order="${data[3]}"

# get data from API

source_path=$(./download_data.sh $data_range)


echo '    <h2 class="table-title">'
echo "      $cat_title Tabelle"
echo '    </h2>'

echo '    <div class="btn-group border border-secondary mb-3 mr-2" role="group" aria-label="Data Range">'
          while read title count; do
            echo "  <a href=\"view_data.sh?cat_id=${cat_id}&range=${count}&order=${data_order}\" class=\"btn btn-light text-dark\">$title</a>"
          done <<< $(cat data/data_range.dat)
echo '    </div>'

echo '    <div class="btn-group border border-secondary mb-3 mr-2" role="group" aria-label="Data Order">'
          while read id title; do
            echo "  <a href=\"view_data.sh?cat_id=${cat_id}&range=${count}&order=${id}\" class=\"btn btn-light text-dark\">$title</a>"
          done <<< $(cat data/order_types.dat)
echo '    </div>'

rainform_col=2 # to convert form id in text

fileinfo=( $(./get_filename_by_cat_id.sh "$cat_id") )
filename=${fileinfo[0]}
filecols=${fileinfo[1]}

echo '
<table class="table table-hover border border-light">
  <thead>
    <tr class="bg-dark text-warning">'

    while read line; do
      echo "<th scope=\"col\">$line</th>"
    done <<< $(cat "data/${filecols}")

echo '
    </tr>
  </thead>
  <tbody>
'
  # Define order of Data
  data_call="tac"
  if [ $data_order = 1 ]; then
    data_call="cat"
  fi 


  i=1
  while read line; do
  echo '<tr>'
    k=0
    for val in $line; do
      if [ $k = 0 ]; then
        echo "<th scope=\"row\">$i</th>"
      fi

      if [ $k = $rainform_col ]; then
        val=$(./get_rain_form1.sh "$val")
      fi

      echo "<td>$val</td>"
      ((k+=1))
    done
  echo '</tr>'
  ((i+=1))
  done <<< $($data_call "${source_path}/${filename}")


echo '
  </tbody>
</table>

'