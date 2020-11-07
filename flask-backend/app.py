from flask import Flask
import requests
from config import api_key
import json

app = Flask(__name__)


"""
Params:
ingredients - a string that contains all of the ingredients separated by a comma
number - the maximum number of recipes to return
Returns a dictionary with a single element, data. Data contains a list of json recipes.
Each json includes:
name - the name of the food
url - the url of the recipe
img - the url of a picture of the good
cuisine - the cuisine the food belongs to, is set to none if there is no assigned cuisine
ingredients - a list of the user's ingredients that are used in the recipe
"""
@app.route("/<ingredients>/<number>")
def hello(ingredients="", number=0):
    data_list = getRecipe(ingredients, number)
    recipe_list = []
    for data in data_list:
        recipe_obj = {}
        more_data = getMoreInfo(data["id"])
        recipe_obj["name"] = data["title"]
        recipe_obj["url"] = more_data["sourceUrl"]
        recipe_obj["img"] = data["image"]
        recipe_obj["cuisine"] = "None"
        if more_data["cuisines"] != []:
            recipe_obj["cuisine"] = ", ".join(more_data["cuisines"])
        recipe_obj["ingredients"] = []
        for ingredient in data["usedIngredients"]:
            recipe_obj["ingredients"].append(ingredient["name"])
        recipe_json = json.dumps(recipe_obj)
        recipe_list.append(recipe_json)
    data_dict = {"data": recipe_list}
    return data_dict

def getRecipe(ingredients, number):
   URL = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=" + api_key
   PARAMS = {'ingredients': ingredients, 'number': number, 'ranking': 1, 'ignorePantry': False}
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
