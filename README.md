### Exemple 
```
name: create gist

on: [push]

jobs:
  create_gist:
    runs-on: self-hosted
    name: A job to create a gist
    steps:
      - uses : cruizsan/github-action-gists@master
        id: create_gist
        with:
          auth: ${{ secrets.CREATE_GIST_AUTH }}
          title: 'title'
          content: 'content'
          description: 'description'
          public: false
          response_field: 'all'
      - name: Get response from github API
        run: echo "The response was ${{ steps.create_gist.outputs.response }}"
```

### params
##### Input
* auth : username:[password|token]
* title (string only)
* content (string only)
* description (string only)
* public : true/false
* response_field : all/url
##### Output
* response
