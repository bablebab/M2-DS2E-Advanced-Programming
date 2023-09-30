:: Lancer shiny.r à travers Rscript
start Rscript shiny.r

:: Installer les dépendances Python
pip install -r requirements.txt

:: Lancer dashboard.py
start python dashboard.py

:: Ouvrir http://localhost:8050/ dans le navigateur par défaut
start http://localhost:8050/

echo Les applications sont lancées!
pause
