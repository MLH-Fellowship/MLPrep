from flask import Flask
import requests
from config import api_key
import json

app = Flask(__name__)
ingredients_list = ["oranges", "pears"]
ingredients = ",".join(ingredients_list)


"""
Returns a dictionary with a single element, data. Data contains a list of json recipes. Each json includes:
name - the name of the food
url - the url of the recipe
img - the url of a picture of the good
cuisine - the cuisine the food belongs to, is set to none if there is no assigned cuisine
ingredients - a list of the user's ingredients that are used in the recipe
"""
@app.route("/")
def hello():
    data_list = getRecipe()
    recipe_list = []
    for data in data_list:
        recipe_obj = {}
        more_data = getMoreInfo(data["id"])
        recipe_obj["name"] = data["title"]
        recipe_obj["url"] = more_data["sourceUrl"]
        recipe_obj["img"] = data["image"]
        recipe_obj["cuisine"] = "None"
        if more_data["cuisines"] != []:
            recipe_obj["cuisine"] = more_data["cuisines"][0]
        recipe_obj["ingredients"] = []
        for ingredient in data["usedIngredients"]:
            recipe_obj["ingredients"].append(ingredient["name"])
        recipe_json = json.dumps(recipe_obj)
        recipe_list.append(recipe_json)
    print(recipe_list)
    data_dict = {"data": recipe_list} 
    return data_dict

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
