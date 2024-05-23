//
//  PetRepo.swift
//  Tamaghostchi
//
//  Created by Vincent Junior Halim on 21/05/24.
//

import Foundation

class PetRepo{
    private var PET_KEY = "PEY_KEY"
    private var pet: Pet
    init() {
            if let data = UserDefaults.standard.data(forKey: PET_KEY) {
                if let decoded = try? JSONDecoder().decode(Pet.self, from: data) {
                    self.pet = decoded
                    print("Pet data successfully retrieved!")
                    return
                }
            }
        self.pet = Pet(lastMeal: Date(), lastPlay: Date(), hungerValue: 0.4, funValue: 0.2, coinValue: 0.0)
        }
        
        func loadData() -> Pet {
            return self.pet
        }
        
        func saveData(pet: Pet) {
            if let encoded = try? JSONEncoder().encode(pet) {
                UserDefaults.standard.set(encoded, forKey: PET_KEY)
                
                print("Data saved at: \(Date().formatted(date: .omitted, time: .standard))")
            }
        }
}
