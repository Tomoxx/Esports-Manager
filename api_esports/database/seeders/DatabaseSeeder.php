<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            TeamsSeeder::class,
            PlayersSeeder::class,
            VenuesSeeder::class,
            TournamentsSeeder::class,
            TournamentTeamsSeeder::class,
            MatchesSeeder::class
        ]);
        // User::factory(10)->create();
    }
}
