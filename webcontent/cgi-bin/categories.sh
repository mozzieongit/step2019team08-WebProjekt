#!/bin/bash
echo "Content-type: text/html"
echo ""

echo '
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	
	<link rel="stylesheet" href="../css/style.css" />
	
	 <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <!-- Fonawesome 4.7.0 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

	<title>Daten-Kategorien</title>
</head>
<body>
'

  ./navbar.sh

echo '
<main class="wrapper container-fluid">
		<h1 class="cat-page-title">Wählen Sie der Daten-Kategorien</h1>

		<section class="categories-container">
			<div class="row">
'
        cat data/categories.dat | while read c_link c_title c_icon; do
          echo '
			    	<div class="col-md-4">
					    <article class="category-card">
					    	<div class="category-card__ico">
          '
			    echo "  <img src=\"$c_icon\" title=\"Icons made by Freepik and Vitaly Gorbachev from www.flaticon.com\" alt=\"$c_title\">
			          </div>
					    	<div class=\"category-card__title\">
							  	<a href=\"$c_link\" class=\"link__block\"></a>
			            <p>$c_title</p>
			      	  </div>
					    </article>
				    </div>
          "
        done 
echo '

			</div>
		</section>

	</main>

	<footer class="bg-dark text-light">
		<div class="container-fluid page-footer__content py-4">
			<div class="row">
				<div class="col-md-8">
					<h5 class="footer-title">
						Team 8 - Web Application
					</h5>
					<p class="pst footer-info pb-4">
						Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ullam placeat, natus quidem possimus sunt fuga adipisci deleniti vitae. Ipsam, est.
					</p>
				</div>
				<div class="col-md-4">
					<h5 class="footer-title">Links</h5>
					<div class="row">
						<div class="col-6">
							<ul class="list-unstyled footer-menu">
								<li><a href="index.html">Home</a></li>
								<li><a href="categories.html">Data</a></li>
								<li><a href="#">Docs</a></li>
								<li><a href="team.html">Team</a></li>
								<li><a href="credits.html">Credits</a></li>
							</ul>
						</div>
						<div class="col-6">
							<ul class="list-unstyled footer-menu">
								<li><a href="index.html">Temperatur</a></li>
								<li><a href="categories.html">Niederschlag</a></li>
								<li><a href="#">Windstärke</a></li>
							</ul>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		<div class="container-fluid text-center page-footer__rights py-2">
			<small>2020 © Team 8</small>
		</div>
	</footer>
</body>
</html>'
