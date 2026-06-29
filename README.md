# Popcorn

A native iOS movie discovery app built with SwiftUI as a dive into Swift, MVVM architecture, SwiftData, and async/await. Browse trending films, search the full TMDB catalogue, watch trailers, and manage a personal watchlist.

## Features

- **Discover** — Featured hero card for the week's top film, plus horizontal carousels for Trending and Now Playing
- **Search** — Live search, infinite scroll pagination
- **Detail** — Full movie page with backdrop, genres, runtime, rating, cast, and in-app YouTube trailer playback
- **Watchlist** — Save and remove movies with SwiftData
- **Appearance** — Light / Dark / System theme picker backed by AppStorage
- **Notifications** — Optional daily new-release reminder

## Tech Stack

| Area | Technology |
|---|---|
| Language | Swift 5.9 |
| UI | SwiftUI |
| Persistence | SwiftData |
| Networking | `URLSession` with a generic `APIClient` |
| Notifications | `UserNotifications` framework |
| Data source | [TMDB API v3](https://developer.themoviedb.org/) |
| Min deployment | iOS 18 |

## Architecture

The app follows a strict **MVVM layering** with a unidirectional dependency graph. Every layer has a single responsibility and knows nothing about the layers above it.

```
View  →  ViewModel  →  Service  →  APIClient  →  URLSession
```

- **Views** read `Loadable` state and render.
- **ViewModels** call services, catch errors, and update `Loadable`.
- **Services** are pure data fetchers. They return decoded domain types or throw. No UI awareness.

### Project Structure

```
popcorn-ios/
├── App/            # Entry point, root TabView
├── Core/           # APIClient, Endpoint, Loadable, Secrets, NotificationService
├── Models/         # Domain types (Movie, MovieDetail, Genre, Video, SavedMovie)
├── Services/       # MovieService — all TMDB fetch calls
├── Features/       # One folder per screen (Discover, Search, Detail, Watchlist, Profile)
├── Components/     # App-wide reusable views (PosterCard, MovieCarousel, MovieRow…)
└── DesignSystem/   # Font, Spacing, and CornerRadius tokens — no magic numbers in views
```

### Design System

Colors, typography, and spacing are all defined once as named tokens and reused throughout the app. Changing the brand color or base spacing updates the entire interface from a single place.

## Getting Started

### Prerequisites

- Xcode 16+
- iOS 18 simulator or device
- A free [TMDB account](https://www.themoviedb.org/) with a **Read Access Token** (not the API key)

### Setup

1. **Clone the repo**

   ```bash
   git clone https://github.com/your-username/popcorn-ios.git
   cd popcorn-ios
   ```

2. **Add your TMDB token**

   Create `popcorn-ios/Secrets.xcconfig` (already gitignored):

   ```
   TMDB_API_KEY = your_read_access_token_here
   ```

3. **Open in Xcode**

   ```bash
   open popcorn-ios/popcorn-ios.xcodeproj
   ```

4. **Run** — select a simulator and press `Cmd+R`.

> The app will build and run without any additional package installation. There are no third-party dependencies.

## API Reference

All data comes from the [TMDB API v3](https://developer.themoviedb.org/reference/intro/getting-started). Authentication uses a Bearer token in the `Authorization` header.

| Endpoint                                    | Used for                        |
| ------------------------------------------- | ------------------------------- |
| `GET /trending/movie/week`                  | Trending carousel               |
| `GET /movie/now_playing`                    | Now Playing carousel            |
| `GET /movie/{id}?append_to_response=videos` | Detail + trailer in one request |
| `GET /search/movie`                         | Search with pagination          |

## What I Learned

A first experiment with mobile development, coming from a front-end background

- Structuring an app with clear separation of concerns (MVVM)
- Building UIs with SwiftUI
- Calling REST APIs and parsing JSON without any external dependencies
- Working with platform-native concurrency, persistence, and notifications instead of third-party libraries
- Modelling data with typed structs and enums to prevent shape mismatches