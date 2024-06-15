<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Venue extends Model
{
    use HasFactory;
    protected $table = 'venues';
    public function game_matches(): HasMany
    {
        return $this->hasMany(GameMatch::class);
    }
}
