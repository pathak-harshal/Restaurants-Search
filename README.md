# Restaurants-Search
This is small working demo of MVVM Design pattern with Yelp business search API


## Installation
Make a clone of this repository and open this directory in a terminal and run following command

```bash
pod install
```

## Usage
Create a application on [Yelp](https://www.yelp.com/login?return_url=%2Fdevelopers%2Fv3%2Fmanage_app) & create API key using this [guide](https://www.yelp.com/developers/documentation/v3/authentication)

Add this token in following file
```bash
ApiManager.swift
```

after Bearer word
```bash
//FIXME: Add Bearer token below
var authHeaders: HTTPHeaders = ["Authorization": "Bearer "]
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
