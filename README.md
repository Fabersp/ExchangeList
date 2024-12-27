
# 📊 **ExchangeList iOS Application**

An **iOS application** built using **Swift**, designed to display cryptocurrency exchange data fetched from **CoinAPI**. The app leverages an **MVVM architecture** with a **Coordinator pattern** for navigation, ensuring clean separation of concerns and scalability.

---

## 🌟 **Overview**

The **ExchangeList iOS App** is built to provide users with an intuitive interface for browsing cryptocurrency exchanges, viewing detailed statistics, and exploring trading data. The app consumes real-time data from CoinAPI and displays information such as:

- Exchange Name  
- Trading Volume (1h, 24h, 30d)  
- Exchange Icons  

---

## 🚀 **Key Features**

- **📄 List of Exchanges:** Display all exchanges with key trading statistics.  
- **📊 Detailed View:** Show detailed information for each selected exchange.  
- **🔄 Data Fetching:** Real-time data fetched using `URLSession`.  
- **🖼️ Icons Support:** Fetch and display exchange icons from API.  
- **🧩 MVVM Architecture:** Ensures modular and testable code.  
- **🧭 Coordinator Pattern:** Clean and decoupled navigation flow.  
- **✅ Unit Testing:** Validate API interactions with mock services.  

---

## 🛠️ **Technologies and Libraries Used**

### **Frameworks & Technologies:**  
- **Swift 5.0**  
- **UIKit**  
- **Foundation**  
- **URLSession**  
- **XCTest (Unit Testing)**  

### **Architecture:**  
- **MVVM (Model-View-ViewModel)**  
- **Coordinator Pattern**  

---

## 📲 **Installation Guide**

### **Prerequisites:**  
- **Xcode 15+**  
- **Swift Package Manager**  

### **Steps:**

1. **Clone the Repository:**  
   ```bash
   git clone https://github.com/fabersp/ExchangeList.git
   cd ExchangeList
   ```

2. **Open in Xcode:**  
   ```bash
   open ExchangeList.xcodeproj
   ```

3. **Run the Project:**  
   - Select a simulator or connected device.  
   - Press **Cmd + R** to run.  

---

## 📸 **Screenshots**

| Exchange List | Exchange Details |  
|---------------|-------------------|  
| ![Exchange List](/Screenshots/list.png) | ![Exchange Details](/Screenshots/details.png) |  

---

## 🧠 **Code Examples**

### **Coordinator Example:**

```swift
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ExchangeListViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetail(for exchange: Exchange) {
        let detailViewController = ExchangeDetailViewController()
        detailViewController.exchange = exchange
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
```

### **API Call Example:**

```swift
func fetchExchangesAndIcons(completion: @escaping ([Exchange]) -> Void) {
    let exchangesURL = URL(string: "https://rest.coinapi.io/v1/exchanges")!
    let iconsURL = URL(string: "https://rest.coinapi.io/v1/exchanges/icons/32")!
    
    var exchanges: [Exchange] = []
    var icons: [ExchangeIcon] = []
    
    let dispatchGroup = DispatchGroup()
    
    dispatchGroup.enter()
    session.dataTask(with: exchangesURL) { data, _, error in
        if let data = data {
            exchanges = try! JSONDecoder().decode([Exchange].self, from: data)
        }
        dispatchGroup.leave()
    }.resume()
    
    dispatchGroup.enter()
    session.dataTask(with: iconsURL) { data, _, error in
        if let data = data {
            icons = try! JSONDecoder().decode([ExchangeIcon].self, from: data)
        }
        dispatchGroup.leave()
    }.resume()
    
    dispatchGroup.notify(queue: .main) {
        for i in 0..<exchanges.count {
            if let icon = icons.first(where: { $0.exchange_id == exchanges[i].exchange_id }) {
                exchanges[i].icon_url = icon.url
            }
        }
        completion(exchanges)
    }
}
```

### **Unit Test Example:**

```swift
func testFetchExchangesAndIconsSuccess() {
    let expectation = XCTestExpectation(description: "Fetch exchanges and icons")
    
    networkService.fetchExchangesAndIcons { exchanges in
        XCTAssertFalse(exchanges.isEmpty, "Expected at least one exchange")
        expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 3.0)
}
```

---

## 🧑‍💻 **Developers**

- **Lead Developer:** Fabricio Aguiar de Padua
- **LinkedIn:** www.linkedin.com/fabricio-padua  
- **contact:** fabricio_0505_@hotmail.com

---

## 📜 **License**

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.

---

## 🤝 **Acknowledgments**

- **CoinAPI:** For the rich cryptocurrency data.  
- **Swift Community:** For tools and inspiration.  


