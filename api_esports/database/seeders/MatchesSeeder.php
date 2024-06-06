<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class MatchesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('matches')->insert([
            'tournament_id' => 1,
            'home_team_id' => 1,
            'away_team_id' => 2,
            'venue_id' => null,
            'match_date' => '2024-05-25 16:00:00',
            'home_team_score' => 1,
            'away_team_score' => 4,
        ]);
    }
}
