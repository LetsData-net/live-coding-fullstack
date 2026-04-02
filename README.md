# Live coding - Full Stack Engineer

![work-smart-not-hard.svg](assets/work-smart-not-hard.svg)

## Installing 

Python 3.10+ is a must

Clone the repository in the terminal:
`git clone https://github.com/LetsData-net/live-coding-fullstack.git`

---

## auto run
install requirements, create db, run backend and frontend:
```bash
make up
```

run backend and frontend:
```bash
make dev
```

run backend only:
```bash
make backend
```

run frontend only:
```bash
make frontend
```

install db and required packages:
```bash
make install
```

create db:
```bash
make db-init
```   

reset db: 
```bash
make db-reset
```
---

## manual run

### backend

```bash
python -m venv venv
# On Unix/MacOS:
source .venv/bin/activate 
# On Windows: 
.venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

### Frontend

1. Go to the `frontend` folder:
   `cd frontend`
2. Install requirements: `npm i`
3. Run the frontend part: `npm run dev`
