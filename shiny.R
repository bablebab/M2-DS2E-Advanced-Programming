########################## PACKAGES ##########################

library(dplyr)
library(ggplot2)
library(forecast)
library(tidyr)
library(readxl)
library(vioplot)
library(lubridate)
library(purrr)
library(fable)
library(fabletools)
library(forecast)
library(tidyverse)
library(zoo)
library(randomForest)

########################## DONNÉES ############################

# Chargement des données

# Chargement de la bibliothèque 'dplyr' pour manipuler les données
library(dplyr)

# Création des modalités de la colonne "Typologie"
modalites_typologie <- c(
  "Bi (Outil Décisionnel, Reporting et Statistiques)",
  "Cabinet Conseil",
  "Cao / Fao (Logiciel De Conception 3d)",
  "Comptabilité",
  "Consolidation",
  "Crm (Gestion De La Relation Client)",
  "Dématérialisation",
  "Dématérialisation Des Bulletins De Paie",
  "Développement Spécifique",
  "Distribution (Retail / Gestion De Point De Vente)",
  "Elaboration Budgétaire",
  "Ged (Gestion Electronique De Documents)",
  "Géolocalisation",
  "Gestion Commerciale",
  "Gestion De Chantier",
  "Gestion De Point De Vente / Retail / Distribution",
  "Gestion De Projets",
  "Gestion De Stock",
  "Gestion De Transport",
  "Gestion Des Achats",
  "Gestion Des Interventions - Solution De Mobilité",
  "Gestion Des Notes De Frais",
  "Gestion Des Temps / Badgeuse",
  "Gestion Du Recouvrement",
  "Gestion Par Affaire",
  "Gmao (Gestion De La Maintenance)",
  "Gpao (Gestion De Production)",
  "Gpec Gestion Prévisionnelle De L'emploi et Des Compétences",
  "Immobilisations",
  "Liasse Fiscale",
  "Logistique (Gestion D'entrepôt / Wms)",
  "Mes (Pilotage De Production)",
  "Paie",
  "Planification / Ordonnancement",
  "Prise De Commandes",
  "Rh / Sirh",
  "Site Internet",
  "Trésorerie"
)

# Création des modalités de la colonne "NAF"
modalites_NAF <- c(
  "0111z", "0113z", "0121z", "0128z", "0162z", "0321z", "1011z", "1013a", "1013b", "1039b",
  "1051a", "1061b", "1071a", "1071d", "1082z", "1083z", "1085z", "1089z", "1392z", "1393z",
  "1396z", "1413z", "1414z", "1512z", "1610a", "1621z", "1623z", "1721b", "1723z", "1820z",
  "2014z", "2051z", "2060z", "2120z", "2219z", "2221z", "2222z", "2229a", "2229b", "2361z",
  "2370z", "2399z", "2420z", "2431z", "2433z", "2511z", "2512z", "2550b", "2561z", "2562b",
  "2573a", "2592z", "2594z", "2611z", "2612z", "2651a", "2651b", "2711z", "2712z", "2790z",
  "2812z", "2814z", "2815z", "2822z", "2829b", "2830z", "2841z", "2849z", "2895z", "2896z",
  "2899b", "2910z", "2920z", "2932z", "3011z", "3030z", "3092z", "3101z", "3109a", "3230z",
  "3250a", "3299z", "3311z", "3312z", "3313z", "3314z", "3315z", "3320a", "3320b", "3320c",
  "3320d", "3511z", "3513z", "3514z", "3700z", "3812z", "3832z", "4110a", "4120a", "4120b",
  "4211z", "4213a", "4222z", "4299z", "4312a", "4312b", "4321a", "4321b", "4322a", "4322b",
  "4329a", "4329b", "4332a", "4332b", "4332c", "4333z", "4334z", "4391a", "4399a", "4399c",
  "4399d", "4511z", "4520a", "4520b", "4531z", "4532z", "4540z", "4617a", "4619a", "4619b",
  "4621z", "4631z", "4634z", "4635z", "4636z", "4638b", "4639a", "4639b", "4641z", "4643z",
  "4645z", "4646z", "4649z", "4651z", "4652z", "4661z", "4662z", "4665z", "4666z", "4669a",
  "4669b", "4669c", "4671z", "4673a", "4673b", "4674a", "4675z", "4676z", "4690z", "4711b",
  "4719b", "4721z", "4729z", "4741z", "4752a", "4754z", "4759a", "4764z", "4771z", "4772a",
  "4776z", "4778a", "4778c", "4781z", "4791a", "4791b", "4931z", "4939b", "4939c", "4941a",
  "4941b", "5210b", "5223z", "5229a", "5229b", "5530z", "5610a", "5610c", "5621z", "5629b",
  "5819z", "5829b", "5829c", "6120z", "6201z", "6202a", "6202b", "6203z", "6209z", "6311z",
  "6419z", "6420z", "6430z", "6491z", "6511z", "6512z", "6619b", "6622z", "6630z", "6820a",
  "6820b", "6831z", "6910z", "6920z", "7010z", "7021z", "7022z", "7111z", "7112b", "7120b",
  "7211z", "7219z", "7220z", "7311z", "7320z", "7410z", "7430z", "7490a", "7490b", "7500z",
  "7732z", "7739z", "7820z", "7830z", "7911z", "7912z", "8010z", "8020z", "8121z", "8129a",
  "8130z", "8211z", "8292z", "8299z", "8411z", "8412z", "8425z", "8430a", "8430b", "8532z",
  "8542z", "8559a", "8621z", "8710a", "8710b", "8710c", "8790b", "8810a", "8810c", "8891a",
  "8891b", "8899b", "9003b", "9102z", "9103z", "9412z", "9491z", "9499z", "9511z", "9529z"
)

# Création des modalités de la colonne "modalites_dpt"
modalites_dpt <- c(
  "1", "10", "11", "12", "13", "14", "15", "17", "18", "2", "21", "22", "24",
  "25", "26", "27", "28", "29", "2a", "2b", "3", "30", "31", "32", "33", "34",
  "35", "36", "37", "38", "39", "4", "40", "41", "42", "43", "44", "45", "46",
  "47", "48", "49", "5", "50", "51", "53", "54", "55", "56", "57", "59", "6",
  "60", "61", "62", "62*", "63", "64", "65", "66", "67", "68", "69", "7", "70",
  "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83",
  "84", "85", "86", "87", "88", "89", "9", "90", "91", "92", "93", "94", "95",
  "98", "monaco"
)


# Génération des données
set.seed(123)  # Pour la reproductibilité des résultats
data <- data.frame(
  Id = 1:12000,
  Typologie = sample(modalites_typologie, 12000, replace = TRUE),
  Mois = format(
    seq(as.Date("2019-01-01"), as.Date("2023-12-01"), by = "month"), 
    format = "%m-%Y"
  ),
  NAF = sample(modalites_NAF, 12000, replace = TRUE),
  Département = sample(modalites_dpt, 12000, replace = TRUE)
)

# Convertir les colonnes en facteurs
data$NAF <- as.factor(data$NAF)
data$Département <- as.factor(data$Département)
data$Mois <- as.factor(data$Mois)
data$Typologie <- as.factor(data$Typologie)


############## Modèle ###############

# Créer la table
table_mode <- data %>%
  group_by(NAF, Département) %>%
  count(Typologie) %>%
  top_n(1, wt = n)

type_data <- data %>%
  select(NAF, Département, Typologie)
  
library(ranger)

# Entraîner le modèle de forêt aléatoire
model <- ranger(Typologie ~ ., data = type_data, importance = 'impurity', probability = TRUE)

# Créer un dataframe avec des combinaisons d'un sous-ensemble de vos données
combinaisons <- expand.grid(NAF = levels(data$NAF), # Remplacer 100 par le nombre de niveaux que vous voulez inclure
                            Département = levels(data$Département))

# Prédire la typologie pour chaque combinaison
predictions <- predict(model, data = combinaisons, type='response')

# Les probabilités sont stockées dans le champ `predictions`
proba <- data.frame(predictions$predictions)

# Pour chaque ligne, trier les probabilités en ordre décroissant et conserver uniquement les trois premières
top3 <- t(apply(proba, 1, function(x) {
  names(sort(x, decreasing = TRUE))[1:3]
}))

# Ajouter les prédictions au dataframe
combinaisons$Top1_Typologie <- top3[, 1]
combinaisons$Top2_Typologie <- top3[, 2]
combinaisons$Top3_Typologie <- top3[, 3]

# Extraire les probabilités correspondantes
combinaisons$Top1_Proba <- sapply(1:nrow(combinaisons), function(i) proba[i, combinaisons$Top1_Typologie[i]])
combinaisons$Top2_Proba <- sapply(1:nrow(combinaisons), function(i) proba[i, combinaisons$Top2_Typologie[i]])
combinaisons$Top3_Proba <- sapply(1:nrow(combinaisons), function(i) proba[i, combinaisons$Top3_Typologie[i]])

combinaisons <- combinaisons %>%
  mutate(
    Top1_Typologie = gsub("\\.", "-", Top1_Typologie),
    Top2_Typologie = gsub("\\.", "-", Top2_Typologie),
    Top3_Typologie = gsub("\\.", "-", Top3_Typologie)
  )

joined <- inner_join(combinaisons, table_mode, by = c("NAF", "Département"))

joined <- joined %>%
  mutate(
    Typologie = gsub("\\,", "-", Typologie)
  )

# Ajouter une colonne pour indiquer si la prédiction est correcte
joined$Prediction_Correcte <- ifelse(joined$Top1_Typologie == joined$Typologie | joined$Top2_Typologie == joined$Typologie | joined$Top3_Typologie == joined$Typologie, 1, 0)

total_predictions <- nrow(joined)

# Comparaison avec Top1_Typologie
correct_predictions1 <- nrow(filter(joined, as.character(Top1_Typologie) == Typologie))
percentage_correct1 <- (correct_predictions1 / total_predictions) * 100
print(paste("Pourcentage de prédictions correctes pour la typologie 1 seulement :", percentage_correct1, "%"))

# Comparaison avec Top2_Typologie
correct_predictions2 <- nrow(filter(joined, as.character(Top2_Typologie) == Typologie))
percentage_correct2 <- (correct_predictions2 / total_predictions) * 100
print(paste("Pourcentage de prédictions correctes avec Top2_Typologie :", percentage_correct2, "%"))

# Comparaison avec Top3_Typologie
correct_predictions3 <- nrow(filter(joined, as.character(Top3_Typologie) == Typologie))
percentage_correct3 <- (correct_predictions3 / total_predictions) * 100
print(paste("Pourcentage de prédictions correctes avec Top3_Typologie :", percentage_correct3, "%"))

# Comparaison avec tout
correct_predictions_total <- nrow(filter(joined, as.character(Top1_Typologie) == Typologie |
                                           as.character(Top2_Typologie) == Typologie |
                                           as.character(Top3_Typologie) == Typologie))
percentage_correct_total <- (correct_predictions_total / total_predictions) * 100
print(paste("Pourcentage de prédictions correctes pour les 3 :", percentage_correct_total, "%"))

table_mode$NAF <- as.factor(table_mode$NAF)
table_mode$Département <- as.factor(table_mode$Département)
combinaisons$NAF <- as.factor(combinaisons$NAF)
combinaisons$Département <- as.factor(combinaisons$Département)

combinaisons <- combinaisons %>%
  mutate(
    Top1_Typologie = gsub("\\.", "-", Top1_Typologie),
    Top2_Typologie = gsub("\\.", "-", Top2_Typologie),
    Top3_Typologie = gsub("\\.", "-", Top3_Typologie)
  )

joined <- inner_join(combinaisons, table_mode, by = c("NAF", "Département"))

joined <- joined %>%
  mutate(
    Typologie = gsub("\\,", "-", Typologie)
  )

# Ajouter une colonne pour indiquer si la prédiction est correcte
joined$Prediction_Correcte <- ifelse(joined$Top1_Typologie == joined$Typologie | joined$Top2_Typologie == joined$Typologie | joined$Top3_Typologie == joined$Typologie, 1, 0)

total_predictions <- nrow(joined)

# Comparaison avec Top1_Typologie
correct_predictions1 <- nrow(filter(joined, as.character(Top1_Typologie) == Typologie))
percentage_correct1 <- (correct_predictions1 / total_predictions) * 100
print(paste("Pourcentage de prédictions correctes pour la typologie 1 seulement :", percentage_correct1, "%"))

# Comparaison avec Top2_Typologie
correct_predictions2 <- nrow(filter(joined, as.character(Top2_Typologie) == Typologie))
percentage_correct2 <- (correct_predictions2 / total_predictions) * 100
print(paste("Pourcentage de prédictions correctes avec Top2_Typologie :", percentage_correct2, "%"))

# Comparaison avec Top3_Typologie
correct_predictions3 <- nrow(filter(joined, as.character(Top3_Typologie) == Typologie))
percentage_correct3 <- (correct_predictions3 / total_predictions) * 100
print(paste("Pourcentage de prédictions correctes avec Top3_Typologie :", percentage_correct3, "%"))

# Comparaison avec tout
correct_predictions_total <- nrow(filter(joined, as.character(Top1_Typologie) == Typologie |
                                           as.character(Top2_Typologie) == Typologie |
                                           as.character(Top3_Typologie) == Typologie))
percentage_correct_total <- (correct_predictions_total / total_predictions) * 100
print(paste("Pourcentage de prédictions correctes pour les 3 :", percentage_correct_total, "%"))





######## FENETRE #########
library(shiny)

# Définissez l'interface utilisateur
ui <- fluidPage(
  titlePanel("Obtenir les typologies et les probabilités"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("naf_input", "Entrez le code NAF:", ""),
      textInput("dep_input", "Entrez le département:", ""),
      actionButton("go_button", "Obtenir les typologies et les probabilités")
    ),
    
    mainPanel(
      textOutput("top1_output"),
      textOutput("prob1_output"),
      textOutput("top2_output"),
      textOutput("prob2_output"),
      textOutput("top3_output"),
      textOutput("prob3_output")
    )
  )
)

# Définissez le serveur
server <- function(input, output) {
  
  observeEvent(input$go_button, {
    print("Button Clicked") # Vérifiez si le bouton est cliqué
    naf_val <- as.character(input$naf_input)
    dep_val <- as.character(input$dep_input)
    print(paste("NAF Value: ", naf_val))
    print(paste("Département Value: ", dep_val))
  
    # Obtenez les valeurs d'entrée
    naf_val <- as.character(input$naf_input)
    dep_val <- as.character(input$dep_input)
    
    # Trouvez la ligne correspondante dans le dataframe
    row <- joined[as.character(joined$NAF) == naf_val & as.character(joined$Département) == dep_val, ]
    
    # Mettez à jour les sorties
    output$top1_output <- renderText({paste("Top 1 Typologie: ", row$Top1_Typologie)})
    output$prob1_output <- renderText({paste("Probabilité Top 1 Typologie: ", row$Top1_Proba)})
    output$top2_output <- renderText({paste("Top 2 Typologie: ", row$Top2_Typologie)})
    output$prob2_output <- renderText({paste("Probabilité Top 2 Typologie: ", row$Top2_Proba)})
    output$top3_output <- renderText({paste("Top 3 Typologie: ", row$Top3_Typologie)})
    output$prob3_output <- renderText({paste("Probabilité Top 3 Typologie: ", row$Top3_Proba)})
  })
  
}

# Assurez-vous que vous avez défini 'ui' et 'server' avant cette étape.
app <- shinyApp(ui = ui, server = server)

# Lancez l'application sur le port 1234 (ou tout autre numéro de port de votre choix)
runApp(app, port = 1234)








