//
//  FoodResponse.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 17/01/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import Foundation

struct FoodResponse: Codable {
    let code : String
    let status : Int
    let product: Product?
    let statusVerbose:String
    
    enum CodingKeys: String, CodingKey {
        case code, status, product
        case statusVerbose = "status_verbose"
    }
}

struct Product: Codable {
    let categories: String
    let manufacturingPlacesTags: [String]
    let stores: String
    let ingredients: [Ingredient]
    let nutritionScoreDebug: String
    let imageThumbURL, imageURL: String
    let unknownIngredientsN: Int?
    let nutritionGradeFr, code, ingredientsTextEs, ingredientsN: String
    let ingredientsText, allergens: String
    let brandsTags: [String]
    let nutrientLevels: NutrientLevels
    let maxImgid, productID: String
    let complete: Int?
    let ingredientsOriginalTags: [String]
    let allergensFromIngredients: String
    let ingredientsTags: [String]
    let nutritionGrades: String
    let imageFrontURL: String
    let ingredientsIDSDebug: [String]
    let brands: String
    let ingredientsHierarchy: [String]
    let productNameEs: String
    let imageNutritionSmallURL, imageSmallURL, imageFrontThumbURL, imageIngredientsURL: String
    let allergensFromUser: String?
    let ingredientsDebug: [String?]
    let keywords: [String]
    let imageIngredientsThumbURL: String
    let ingredientsTextWithAllergensEs, genericName: String
    let imageIngredientsSmallURL: String
    let storesTags: [String]
    let completedT: Int?
    let nutritionGradesTags: [String]
    let servingQuantity: Double?
    let languagesHierarchy: [String]
    let packaging: String
    let imageFrontSmallURL: String
    let tracesFromUser, expirationDate: String?
    let selectedImages: SelectedImages
    let allergensHierarchy: [String]
    let novaGroup: CustomValue
    let imageNutritionThumbURL: String
    let codesTags: [String]
    let quantity, nutritionDataPrepared: String
    let productQuantity: Double?
    let servingSize, ingredientsTextWithAllergens: String
    let allergensTags: [String]
    let genericNameEs, ingredientsTextDebug: String
    let nutriments: Nutriments
    
    enum CodingKeys: String, CodingKey {
        case categories
        case manufacturingPlacesTags = "manufacturing_places_tags"
        case stores, ingredients
        case nutritionScoreDebug = "nutrition_score_debug"
        case imageThumbURL = "image_thumb_url"
        case imageURL = "image_url"
        case unknownIngredientsN = "unknown_ingredients_n"
        case nutritionGradeFr = "nutrition_grade_fr"
        case code
        case ingredientsTextEs = "ingredients_text_es"
        case ingredientsN = "ingredients_n"
        case ingredientsText = "ingredients_text"
        case allergens
        case brandsTags = "brands_tags"
        case nutrientLevels = "nutrient_levels"
        case maxImgid = "max_imgid"
        case productID = "id"
        case complete
        case ingredientsOriginalTags = "ingredients_original_tags"
        case allergensFromIngredients = "allergens_from_ingredients"
        case ingredientsTags = "ingredients_tags"
        case nutritionGrades = "nutrition_grades"
        case imageFrontURL = "image_front_url"
        case ingredientsIDSDebug = "ingredients_ids_debug"
        case brands
        case ingredientsHierarchy = "ingredients_hierarchy"
        case productNameEs = "product_name_es"
        case imageNutritionSmallURL = "image_nutrition_small_url"
        case imageSmallURL = "image_small_url"
        case imageFrontThumbURL = "image_front_thumb_url"
        case imageIngredientsURL = "image_ingredients_url"
        case allergensFromUser = "allergens_from_user"
        case ingredientsDebug = "ingredients_debug"
        case keywords = "_keywords"
        case imageIngredientsThumbURL = "image_ingredients_thumb_url"
        case ingredientsTextWithAllergensEs = "ingredients_text_with_allergens_es"
        case genericName = "generic_name"
        case imageIngredientsSmallURL = "image_ingredients_small_url"
        case storesTags = "stores_tags"
        case completedT = "completed_t"
        case nutritionGradesTags = "nutrition_grades_tags"
        case servingQuantity = "serving_quantity"
        case languagesHierarchy = "languages_hierarchy"
        case packaging
        case imageFrontSmallURL = "image_front_small_url"
        case tracesFromUser = "traces_from_user"
        case expirationDate = "expiration_date"
        case selectedImages = "selected_images"
        case allergensHierarchy = "allergens_hierarchy"
        case novaGroup = "nova_group"
        case imageNutritionThumbURL = "image_nutrition_thumb_url"
        case codesTags = "codes_tags"
        case quantity
        case nutritionDataPrepared = "nutrition_data_prepared"
        case productQuantity = "product_quantity"
        case servingSize = "serving_size"
        case ingredientsTextWithAllergens = "ingredients_text_with_allergens"
        case allergensTags = "allergens_tags"
        case genericNameEs = "generic_name_es"
        case ingredientsTextDebug = "ingredients_text_debug"
        case nutriments
    }
}

struct Ingredient: Codable {
    let id, text: String
    let rank: Int?
}

struct NutrientLevels: Codable {
    let sugars, salt, saturatedFat, fat: String
    
    enum CodingKeys: String, CodingKey {
        case sugars, salt
        case saturatedFat = "saturated-fat"
        case fat
    }
}

struct Nutriments: Codable {
    let vitaminB2100G: CustomValue?
    let fiberServing, saltUnit: CustomValue?
    let salt, sodium100G: CustomValue?
    let nutritionScoreFr: CustomValue?
    let vitaminPp: CustomValue?
    let vitaminB2Unit, vitaminPpLabel, calciumLabel, fatValue: CustomValue?
    let monounsaturatedFatValue: CustomValue?
    let vitaminB2, calcium: CustomValue?
    let carbohydratesValue, fiberUnit: CustomValue?
    let vitaminB9: CustomValue?
    let sugars100G, vitaminB1100G, calciumUnit, vitaminPpValue: CustomValue?
    let novaGroupServing, monounsaturatedFatLabel, calciumValue, fiberValue: CustomValue?
    let vitaminB9Label, monounsaturatedFat, energyUnit: CustomValue?
    let proteins100G, iron100G, phosphorus: CustomValue?
    let phosphorusValue, sugarsServing, fiber: CustomValue?
    let calciumServing, saltServing, calcium100G: CustomValue?
    let alcohol, vitaminB9Unit: CustomValue?
    let fatServing: CustomValue?
    let vitaminB2Label, novaGroup: CustomValue?
    let fat: CustomValue?
    let vitaminB1Label, zincUnit: CustomValue?
    let zinc100G, sodiumServing: CustomValue?
    let carbohydratesServing, energyValue, sugarsValue: CustomValue?
    let iron: CustomValue?
    let proteinsServing, vitaminB1Unit, sodiumUnit, sodiumValue: CustomValue?
    let monounsaturatedFat100G: CustomValue?
    let monounsaturatedFatUnit, energy100G, proteinsUnit: CustomValue?
    let fat100G: CustomValue?
    let vitaminB1Serving: CustomValue?
    let vitaminPpServing, vitaminB9100G: CustomValue?
    let alcohol100G, saturatedFatValue: CustomValue?
    let zincServing, ironServing: CustomValue?
    let sugars: CustomValue?
    let phosphorusServing: CustomValue?
    let phosphorusUnit, ironUnit: CustomValue?
    let saturatedFatServing, zinc: CustomValue?
    let saltValue: CustomValue?
    let nutritionScoreUk: CustomValue?
    let vitaminB2Value, energyServing: CustomValue?
    let nutritionScoreFr100G: CustomValue?
    let phosphorus100G: CustomValue?
    let vitaminPpUnit, zincLabel, saturatedFatUnit, vitaminB1Value: CustomValue?
    let sugarsUnit, monounsaturatedFatServing, proteinsValue: CustomValue?
    let carbohydrates100G: CustomValue?
    let energy, vitaminB1: CustomValue?
    let sodium, vitaminB9Serving: CustomValue?
    let zincValue, fiber100G, fatUnit, novaGroup100G: CustomValue?
    let phosphorusLabel, alcoholServing, proteins, ironValue: CustomValue?
    let vitaminB2Serving: CustomValue?
    let alcoholUnit: CustomValue?
    let salt100G: CustomValue?
    let nutritionScoreUk100G: CustomValue?
    let alcoholValue, ironLabel, carbohydratesUnit, vitaminB9Value: CustomValue?
    let saturatedFat100G: CustomValue?
    let carbohydrates: CustomValue?
    let vitaminPp100G, saturatedFat: CustomValue?
    
    enum CodingKeys: String, CodingKey {
        case vitaminB2100G = "vitamin-b2_100g"
        case fiberServing = "fiber_serving"
        case saltUnit = "salt_unit"
        case salt
        case sodium100G = "sodium_100g"
        case nutritionScoreFr = "nutrition-score-fr"
        case vitaminPp = "vitamin-pp"
        case vitaminB2Unit = "vitamin-b2_unit"
        case vitaminPpLabel = "vitamin-pp_label"
        case calciumLabel = "calcium_label"
        case fatValue = "fat_value"
        case monounsaturatedFatValue = "monounsaturated-fat_value"
        case vitaminB2 = "vitamin-b2"
        case calcium
        case carbohydratesValue = "carbohydrates_value"
        case fiberUnit = "fiber_unit"
        case vitaminB9 = "vitamin-b9"
        case sugars100G = "sugars_100g"
        case vitaminB1100G = "vitamin-b1_100g"
        case calciumUnit = "calcium_unit"
        case vitaminPpValue = "vitamin-pp_value"
        case novaGroupServing = "nova-group_serving"
        case monounsaturatedFatLabel = "monounsaturated-fat_label"
        case calciumValue = "calcium_value"
        case fiberValue = "fiber_value"
        case vitaminB9Label = "vitamin-b9_label"
        case monounsaturatedFat = "monounsaturated-fat"
        case energyUnit = "energy_unit"
        case proteins100G = "proteins_100g"
        case iron100G = "iron_100g"
        case phosphorus
        case phosphorusValue = "phosphorus_value"
        case sugarsServing = "sugars_serving"
        case fiber
        case calciumServing = "calcium_serving"
        case saltServing = "salt_serving"
        case calcium100G = "calcium_100g"
        case alcohol
        case vitaminB9Unit = "vitamin-b9_unit"
        case fatServing = "fat_serving"
        case vitaminB2Label = "vitamin-b2_label"
        case novaGroup = "nova-group"
        case fat
        case vitaminB1Label = "vitamin-b1_label"
        case zincUnit = "zinc_unit"
        case zinc100G = "zinc_100g"
        case sodiumServing = "sodium_serving"
        case carbohydratesServing = "carbohydrates_serving"
        case energyValue = "energy_value"
        case sugarsValue = "sugars_value"
        case iron
        case proteinsServing = "proteins_serving"
        case vitaminB1Unit = "vitamin-b1_unit"
        case sodiumUnit = "sodium_unit"
        case sodiumValue = "sodium_value"
        case monounsaturatedFat100G = "monounsaturated-fat_100g"
        case monounsaturatedFatUnit = "monounsaturated-fat_unit"
        case energy100G = "energy_100g"
        case proteinsUnit = "proteins_unit"
        case fat100G = "fat_100g"
        case vitaminB1Serving = "vitamin-b1_serving"
        case vitaminPpServing = "vitamin-pp_serving"
        case vitaminB9100G = "vitamin-b9_100g"
        case alcohol100G = "alcohol_100g"
        case saturatedFatValue = "saturated-fat_value"
        case zincServing = "zinc_serving"
        case ironServing = "iron_serving"
        case sugars
        case phosphorusServing = "phosphorus_serving"
        case phosphorusUnit = "phosphorus_unit"
        case ironUnit = "iron_unit"
        case saturatedFatServing = "saturated-fat_serving"
        case zinc
        case saltValue = "salt_value"
        case nutritionScoreUk = "nutrition-score-uk"
        case vitaminB2Value = "vitamin-b2_value"
        case energyServing = "energy_serving"
        case nutritionScoreFr100G = "nutrition-score-fr_100g"
        case phosphorus100G = "phosphorus_100g"
        case vitaminPpUnit = "vitamin-pp_unit"
        case zincLabel = "zinc_label"
        case saturatedFatUnit = "saturated-fat_unit"
        case vitaminB1Value = "vitamin-b1_value"
        case sugarsUnit = "sugars_unit"
        case monounsaturatedFatServing = "monounsaturated-fat_serving"
        case proteinsValue = "proteins_value"
        case carbohydrates100G = "carbohydrates_100g"
        case energy
        case vitaminB1 = "vitamin-b1"
        case sodium
        case vitaminB9Serving = "vitamin-b9_serving"
        case zincValue = "zinc_value"
        case fiber100G = "fiber_100g"
        case fatUnit = "fat_unit"
        case novaGroup100G = "nova-group_100g"
        case phosphorusLabel = "phosphorus_label"
        case alcoholServing = "alcohol_serving"
        case proteins
        case ironValue = "iron_value"
        case vitaminB2Serving = "vitamin-b2_serving"
        case alcoholUnit = "alcohol_unit"
        case salt100G = "salt_100g"
        case nutritionScoreUk100G = "nutrition-score-uk_100g"
        case alcoholValue = "alcohol_value"
        case ironLabel = "iron_label"
        case carbohydratesUnit = "carbohydrates_unit"
        case vitaminB9Value = "vitamin-b9_value"
        case saturatedFat100G = "saturated-fat_100g"
        case carbohydrates
        case vitaminPp100G = "vitamin-pp_100g"
        case saturatedFat = "saturated-fat"
    }
}

struct SelectedImages: Codable {
    let nutrition, ingredients, front: Front
}

struct Front: Codable {
    let thumb, display, small: Display
}

struct Display: Codable {
    let es: String
}
