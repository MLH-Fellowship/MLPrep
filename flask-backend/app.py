from flask import Flask
import requests
from config import api_key

app = Flask(__name__)
ingredients_list = ["cheese", "bell peppers"]
ingredients = ",".join(ingredients_list)

@app.route("/")
def hello():
    data_list = getRecipe()
    string = ""
    for data in data_list:
        more_data = getMoreInfo(data["id"])
        cuisine = "None"
        if more_data["cuisines"] != []:
            cuisine = more_data["cuisines"][0]
        info = "Title: " + data["title"] + " Missed Ingredients: " + str(data["missedIngredientCount"]) + " Used Ingredients: " + str(data["usedIngredientCount"]) + " Type: " + cuisine
        string += "<h1>" + info + "</h1>" + "<img src=\"" + data["image"] + "\">" + "<a href=\"" + more_data["sourceUrl"] + "\">Link</a>" + "<ul>"
        for ingredient in data["usedIngredients"]:
            string += "<li>" + ingredient["name"] + "</li>"
        string += "</ul>"
        
    return string

def getRecipe():
   URL = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=" + api_key
   PARAMS = {'ingredients': ingredients, 'number': 2, 'ranking': 1, 'ignorePantry': False}
   r = requests.get(url = URL, params = PARAMS)
   data = r.json()
   return data

def getMoreInfo(recipe_id):
    URL = "https://api.spoonacular.com/recipes/" + str(recipe_id) + "/information?apiKey=" + api_key
    r = requests.get(url = URL)
    data = r.json()
    return data


if __name__ == "__main__":
    app.run(host='0.0.0.0')
