import Foundation

class LegderObject {
    var installmentNumber: Int
    var emi: Double
    var interest: Double
    var principal: Double
    var balancePrincipal: Double
    
    init(installmentNumber: Int, emi: Double, interest: Double, principal: Double, balancePrincipal: Double) {
        self.installmentNumber = installmentNumber
        self.emi = emi
        self.interest = interest
        self.principal = principal
        self.balancePrincipal = balancePrincipal
    }
}

class Monetrix {
    let roi: Double = 3.5
    let tenure = 25
    let principal: Double = 800000
    var updatedPricipal: Double = 800000
    
    var legder: [(Int, Double, Double, Double, Double)] = []
    
    init() {
    }
    
    func getInterest() -> Double {
        return getMonthlyInterestRate()*updatedPricipal
    }
    
    func getNumberOfPayments() -> Int {
        return tenure*12
    }
    
    func getMonthlyInterestRate() -> Double {
        return ((roi/100)/12)
    }
    
    func getCompundRate() -> Double {
        let rate = 1 + getMonthlyInterestRate()
        return pow(rate, Double(getNumberOfPayments()))
    }
    
    func getEMIRate() -> Double {
        return (getCompundRate()/(getCompundRate()-1))
    }
    
    func getEMI() -> Double {
        return getEMIRate()*principal*getMonthlyInterestRate()
    }
    
    func getDeductedPrincipal() -> Double {
        return getEMI()-getInterest()
    }
    
    func getBalancePrincipal() -> Double {
        updatedPricipal = updatedPricipal-getDeductedPrincipal()
        return updatedPricipal
    }
    
    func getLedger() {
        for i in 1...getNumberOfPayments() {
            legder.append((i, getEMI().rounded(), getInterest().rounded(), getDeductedPrincipal().rounded(), getBalancePrincipal().rounded()))
        }
    }
}

let user1 = Monetrix()

print(user1.getLedger())
print(user1.legder)


