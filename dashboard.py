#!/usr/bin/env python
# coding: utf-8

# In[17]:


import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output
import plotly.express as px
import pandas as pd
import plotly.graph_objects as go
import statsmodels.api as sm
import dash_bootstrap_components as dbc
import random
import numpy as np

modalites_typologie = [
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
    "Trésorerie" ]
    
modalites_NAF = [
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
    "8891b", "8899b", "9003b", "9102z", "9103z", "9412z", "9491z", "9499z", "9511z", "9529z" ]

modalites_dpt = [
    "1", "10", "11", "12", "13", "14", "15", "17", "18", "2", "21", "22", "24",
    "25", "26", "27", "28", "29", "2a", "2b", "3", "30", "31", "32", "33", "34",
    "35", "36", "37", "38", "39", "4", "40", "41", "42", "43", "44", "45", "46",
    "47", "48", "49", "5", "50", "51", "53", "54", "55", "56", "57", "59", "6",
    "60", "61", "62", "62*", "63", "64", "65", "66", "67", "68", "69", "7", "70",
    "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83",
    "84", "85", "86", "87", "88", "89", "9", "90", "91", "92", "93", "94", "95",
    "98", "monaco" ]

def generate_exponential_data(size, rate):
        return np.random.exponential(scale=1/rate, size=size)
    
rate_for_id = 0.1 
    
data = {
    "Id": generate_exponential_data(12000, rate_for_id),
    "Typologie": [random.choice(modalites_typologie) for _ in range(12000)],
    "Mois": [f"{random.randint(1, 12):02d}-{random.randint(2019, 2023)}" for _ in range(12000)],
    "NAF": [random.choice(modalites_NAF) for _ in range(12000)],
    "Département": [random.choice(modalites_dpt) for _ in range(12000)]
    } 
    
df = pd.DataFrame(data)
    
df['Mois'] = pd.to_datetime(df['Mois'], format='%m-%Y')
    
df = df.sort_values(by='Mois')
    
print(df.head())

app = dash.Dash(__name__, external_stylesheets=[dbc.themes.LUX], suppress_callback_exceptions=True)
    
app.layout = html.Div([
    html.Div(style={'background-color': '#333', 'height': '40px', 'position': 'fixed', 'width': '100%', 'top': '0', 'left': '0', 'z-index': '1000'}),
    html.Div([
        html.H1("Celge Data Dashboard", style={'font-family': 'Arial', 'color': '#333'}),
        dcc.Tabs(id="tabs", value='trends-tab', children=[
            dcc.Tab(label='Statistiques descriptives', value='descriptive-stats-tab', style={'font-family': 'Arial'}),
            dcc.Tab(label='Tendances', value='trends-tab', style={'font-family': 'Arial'}),
            dcc.Tab(label='Outil Commercial', value='commercial-tool-tab', style={'font-family': 'Arial'})
        ]),
    ], style={'position': 'relative', 'top': '40px', 'padding': '20px'}),
    html.Div(id='tabs-content', style={'font-family': 'Arial', 'color': '#333', 'padding': '20px', 'margin-top': '80px'})
    ])
    
@app.callback(
    Output('tabs-content', 'children'),
    Input('tabs', 'value'))
    
def render_content(tab):
    if tab == 'trends-tab':
        typologies = df['Typologie'].unique()
        return html.Div([
            dcc.Dropdown(
                id='typology-dropdown',
                options=[{'label': typology, 'value': typology} for typology in typologies],
                value=typologies[0]
            ),
            dcc.Graph(id='trends-chart'),
            dcc.Graph(id='stl-tendance-graph')  
        ])

    elif tab == 'descriptive-stats-tab':
  
        total_observations = len(df)
        unique_typologies = len(df['Typologie'].unique())
        start_date = df['Mois'].min()
        end_date = df['Mois'].max()


        typology_counts = df['Typologie'].value_counts()
        fig_typology_histogram = px.bar(typology_counts, x=typology_counts.index, y=typology_counts.values, title='Distribution des observations par typologie')
        fig_typology_histogram.update_xaxes(title='Typologie')
        fig_typology_histogram.update_yaxes(title='Nombre d\'observations')


        statistics_text = html.Div([
            html.H3('Statistiques de base', style={'font-family': 'Arial'}),
            html.P(f'Nombre total d\'observations : {total_observations}'),
            html.P(f'Nombre unique de typologies : {unique_typologies}'),
            html.P(f'Période de temps couverte : de {start_date} à {end_date}')
        ])

        return html.Div([
            html.H2("Statistiques descriptives", style={'font-family': 'Arial'}),
            statistics_text,
            dcc.Graph(id='monthly-observations-chart', config={'displayModeBar': False}),
            dcc.Graph(figure=fig_typology_histogram)
        ])
    
    elif tab == 'commercial-tool-tab':

        return html.Div([
            html.H2("Outil Commercial", style={'font-family': 'Arial'}),
             html.Iframe(src="http://127.0.0.1:1234", width="100%", height="600px"),# Vous pouvez ajouter d'autres composants ou fonctionnalités ici.
        ])
    
@app.callback(
    Output('trends-chart', 'figure'),
    Input('typology-dropdown', 'value'))
    
def update_typology_chart(selected_typology):
    filtered_df = df[df['Typologie'] == selected_typology]
    resultat = filtered_df.groupby(['Mois']).size().reset_index(name='Nombre')
    fig = px.line(resultat, x='Mois', y='Nombre', title=f'Évolution de la typologie "{selected_typology}" au fil du temps')
    fig.update_xaxes(tickangle=45, tickfont=dict(size=10))
    
    return fig

@app.callback(
    Output('monthly-observations-chart', 'figure'),
    Input('tabs', 'value'))
    
def update_monthly_observations_chart(tab):
    if tab == 'descriptive-stats-tab':
        observations_par_mois = df.groupby('Mois').size().reset_index(name='Nombre')
        fig = px.line(observations_par_mois, x='Mois', y='Nombre', title='Nombre d\'observations par mois')
        fig.update_traces(mode='markers+lines')
        fig.update_xaxes(tickangle=45, tickfont=dict(size=10))  
        fig.update_layout(template='plotly_white')  
        return fig
    
@app.callback(
    Output("stl-tendance-graph", "figure"),
    Input("typology-dropdown", "value"))
    
    
def update_tendance_graph(selected_typologie):
    if not selected_typologie:
        return go.Figure()

    typologie_df = df[df['Typologie'] == selected_typologie]

    typologie_df['Mois'] = pd.to_datetime(typologie_df['Mois'], format='%m-%Y')
    
    typologie_df = typologie_df.sort_values(by='Mois')

    monthly_data = typologie_df.groupby('Mois')['Id'].count().reset_index()

    decomposition = sm.tsa.seasonal_decompose(monthly_data['Id'], model='additive', period=12)

    fig = go.Figure()

    fig.add_trace(go.Scatter(x=monthly_data['Mois'], y=monthly_data['Id'], mode='lines+markers', name='Observations'))

    fig.add_trace(go.Scatter(x=monthly_data['Mois'], y=decomposition.trend, mode='lines', name='Tendance'))

    fig.add_trace(go.Scatter(x=monthly_data['Mois'], y=decomposition.seasonal, mode='lines', name='Saisonnalité'))

    fig.add_trace(go.Scatter(x=monthly_data['Mois'], y=decomposition.resid, mode='lines', name='Résidus'))

    fig.update_layout(title=f'Analyse STL - Tendances par Typologie ({selected_typologie})', xaxis_title='Mois', yaxis_title='Valeurs')

    return fig

if __name__ == '__main__':
    app.run_server(debug=True)

